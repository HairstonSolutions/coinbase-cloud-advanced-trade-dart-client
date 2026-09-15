import 'dart:convert';
import 'dart:io' show Directory, File;

import 'package:coinbase_cloud_advanced_trade_client/models.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/preview_order.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

/// Acceptance tests for issue #91: monetary and quantity fields must never be
/// parsed through an IEEE `double`.
///
/// See https://github.com/HairstonSolutions/coinbase-cloud-advanced-trade-dart-client/issues/91
void main() {
  group('Money and quantity fields keep decimal precision', () {
    test('Product increments round-trip exactly', () {
      final product = Product.fromCBJson({
        'product_id': 'BTC-USD',
        'price': '43423.01',
        'quote_increment': '0.01',
        'base_increment': '0.00000001',
        'quote_min_size': '1.00',
        'base_min_size': '0.0001',
      });

      expect(product.quoteIncrement, Decimal.parse('0.01'));
      expect(product.quoteIncrement.toString(), '0.01');
      expect(product.baseIncrement, Decimal.parse('0.00000001'));
      expect(product.baseIncrement.toString(), '0.00000001');
      expect(product.price, Decimal.parse('43423.01'));
    });

    test('An exact balance survives parse and re-serialize', () {
      // '61250.10' is not representable as an IEEE double. Decimal keeps the
      // value exactly; note that Decimal normalises the trailing zero, so the
      // serialized form is '61250.1' while the value stays exact.
      final account = Account.fromCBJson({
        'uuid': '8bfc20d7-f7c6-4422-bf07-8243ca4169fe',
        'name': 'USD Wallet',
        'currency': 'USD',
        'available_balance': {'value': '61250.10', 'currency': 'USD'},
        'default': false,
        'active': true,
        'created_at': '2021-05-31T09:59:59Z',
        'updated_at': '2021-05-31T09:59:59Z',
        'type': 'ACCOUNT_TYPE_FIAT',
        'ready': true,
        'hold': {'value': '0.00', 'currency': 'USD'},
      });

      expect(account.availableBalance, Decimal.parse('61250.10'));

      final roundTripped = Account.fromJson(account.toJson());
      expect(roundTripped.availableBalance, Decimal.parse('61250.10'));
      expect(roundTripped.availableBalance, account.availableBalance);

      // The serialized JSON carries the decimal as a string, never a double.
      final encoded = jsonDecode(jsonEncode(account.toJson()));
      expect(encoded['availableBalance'], isA<String>());
      expect(encoded['availableBalance'], '61250.1');
    });

    test('Decimal arithmetic on parsed balances does not drift', () {
      final account = Account.fromCBJson({
        'uuid': 'a',
        'name': 'USD Wallet',
        'currency': 'USD',
        'available_balance': {'value': '0.1', 'currency': 'USD'},
        'default': false,
        'active': true,
        'created_at': '2021-05-31T09:59:59Z',
        'updated_at': '2021-05-31T09:59:59Z',
        'type': 'ACCOUNT_TYPE_FIAT',
        'ready': true,
        'hold': {'value': '0.2', 'currency': 'USD'},
      });

      expect(
          account.availableBalance! + account.holdValue!, Decimal.parse('0.3'));
      // The same sum in binary floating point does not land on 0.3.
      expect(0.1 + 0.2 == 0.3, isFalse);
    });

    test('Increments can be used for exact quantization', () {
      final product = Product.fromCBJson({
        'product_id': 'BTC-USD',
        'base_increment': '0.00000001',
      });

      final size = Decimal.parse('0.30000000');
      final ticks = (size / product.baseIncrement!).toDecimal();

      expect(ticks, Decimal.fromInt(30000000));
      expect(ticks.isInteger, isTrue);
    });

    test('Fill price, size and commission keep full precision', () {
      final fill = Fill.fromCBJson({
        'entry_id': '22222-2222222-22222222',
        'trade_id': '1111-11111-111111',
        'order_id': '0000-000000-000000',
        'trade_time': '2021-05-31T09:59:59Z',
        'trade_type': 'FILL',
        'price': '10000.00',
        'size': '0.00000001',
        'commission': '0.0000000028064',
        'product_id': 'BTC-USD',
        'sequence_timestamp': '2021-05-31T09:58:59Z',
        'liquidity_indicator': 'MAKER',
        'size_in_quote': false,
        'user_id': '2222-000000-000000',
        'side': 'BUY',
      });

      expect(fill.price, Decimal.parse('10000.00'));
      expect(fill.size, Decimal.parse('0.00000001'));
      expect(fill.commission, Decimal.parse('0.0000000028064'));
      expect(fill.commission.toString(), '0.0000000028064');
    });

    test('Order configuration sizes and prices keep full precision', () {
      final order = Order.fromCBJson({
        'order_id': '0000-000000-000000',
        'product_id': 'BTC-USD',
        'user_id': '2222-000000-000000',
        'order_configuration': {
          'limit_limit_gtc': {
            'base_size': '0.00100000',
            'limit_price': '10000.01',
            'post_only': false,
          },
        },
        'side': 'BUY',
        'client_order_id': '11111-000000-000000',
        'status': 'OPEN',
        'time_in_force': 'GOOD_UNTIL_CANCELLED',
        'created_time': '2021-05-31T09:59:59Z',
        'completion_percentage': '50.00',
        'filled_size': '0.00050000',
        'average_filled_price': '10000.01',
        'number_of_fills': '2',
        'filled_value': '5.000005',
        'total_fees': '5.00',
        'total_value_after_fees': '5.00',
      });

      expect(
          order.orderConfiguration?.limitGTC?.baseSize, Decimal.parse('0.001'));
      expect(order.orderConfiguration?.limitGTC?.limitPrice,
          Decimal.parse('10000.01'));
      expect(order.filledValue, Decimal.parse('5.000005'));
      expect(order.averageFilledPrice, Decimal.parse('10000.01'));

      // A count stays an int rather than becoming a Decimal.
      expect(order.numberOfFills, 2);
      expect(order.numberOfFills, isA<int>());
    });

    test('Order configuration serializes decimals as strings', () {
      final order = Order.fromCBJson({
        'order_id': '0000-000000-000000',
        'product_id': 'BTC-USD',
        'user_id': '2222-000000-000000',
        'order_configuration': {
          'limit_limit_gtc': {
            'base_size': '0.001',
            'limit_price': '10000.01',
            'post_only': false,
          },
        },
        'side': 'BUY',
        'client_order_id': '11111-000000-000000',
        'status': 'OPEN',
        'time_in_force': 'GOOD_UNTIL_CANCELLED',
        'created_time': '2021-05-31T09:59:59Z',
      });

      final cbJson = order.orderConfiguration!.toCBJson();
      final limitGtc = cbJson['order_configuration']['limit_limit_gtc']
          as Map<String, dynamic>;

      expect(limitGtc['base_size'], '0.001');
      expect(limitGtc['limit_price'], '10000.01');
      // The payload must survive jsonEncode; a raw Decimal would throw.
      expect(jsonEncode(cbJson), contains('"limit_price":"10000.01"'));
    });
  });

  group('No binary floating point remains in the model layer', () {
    test('No model declares a double or num field', () {
      final offenders = <String>[];
      final fieldDeclaration =
          RegExp(r'^\s*(?:final\s+)?(?:double|num)\??\s+\w+\s*;');

      // server_time.dart holds epoch timestamps, not money. Coinbase sends
      // epochMillis with a fractional part, so it stays numeric.
      const nonMonetary = {'server_time.dart'};

      final modelFiles = Directory('lib/src/models')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .where((file) => !nonMonetary.any(file.path.endsWith));

      for (final file in modelFiles) {
        final lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          if (fieldDeclaration.hasMatch(lines[i])) {
            offenders.add('${file.path}:${i + 1}: ${lines[i].trim()}');
          }
        }
      }

      expect(offenders, isEmpty,
          reason: 'Money and quantity fields must be Decimal, not double/num.');
    });

    test('No model declares a String money or quantity field', () {
      // The double/num guard above did not catch issue #123: the two order
      // preview responses held their totals as raw `String`, which the caller
      // had to run through double.parse to use. That is the same precision
      // loss by a different route, so it is guarded the same way.
      final offenders = <String>[];
      final stringField = RegExp(r'^\s*(?:final\s+)?String\??\s+(\w+)\s*;');
      final monetaryName = RegExp(
          r'price|size|total|balance|rate|fee|amount|buffer|leverage|'
          r'slippage|increment|notional|bid|ask|volume|margin|cost|'
          r'commission|percentage|liquidation|equity|value|quantity',
          caseSensitive: false);

      // Names that match the pattern but are not money:
      //   value      - the wire code on the nine enum wrapper classes
      //                (OrderSide, OrderStatus, ...), e.g. 'UNKNOWN_ORDER_SIDE'
      //   volumeType - which volume a VolumeBreakdown describes, not how much
      //   marginType - which margin a PerpPosition uses, not how much
      const notMonetary = {'value', 'volumeType', 'marginType'};

      final modelFiles = Directory('lib/src/models')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));

      for (final file in modelFiles) {
        final lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          final match = stringField.firstMatch(lines[i]);
          if (match == null) continue;

          final name = match.group(1)!;
          if (notMonetary.contains(name)) continue;
          if (!monetaryName.hasMatch(name)) continue;

          offenders.add('${file.path}:${i + 1}: ${lines[i].trim()}');
        }
      }

      expect(offenders, isEmpty,
          reason: 'Money and quantity fields must be Decimal, not String. '
              'Parse them with nullableDecimal or requiredDecimal.');
    });
  });

  group('The fields converted by #123 keep decimal precision', () {
    test('Preview totals are arithmetic, not String parsing', () {
      final preview = PreviewOrderResponse.fromCBJson({
        'order_total': '10.20',
        'commission_total': '0.05',
        'best_bid': '9999.01',
        'best_ask': '10001.09',
        'est_average_filled_price': '10000.005',
        'slippage': '0.0000000000004495',
      });

      expect(preview.orderTotal! - preview.commissionTotal!,
          Decimal.parse('10.15'));
      expect(preview.bestAsk! - preview.bestBid!, Decimal.parse('2.08'));
      expect(preview.estAverageFilledPrice, Decimal.parse('10000.005'));
      expect(preview.slippage.toString(), '0.0000000000004495');
    });

    test('An empty max_leverage parses to null rather than throwing', () {
      // Spot previews carry no leverage cap and Coinbase sends '' for it,
      // the same way FeeTier.aopTo is empty on the unbounded top tier.
      final preview = PreviewOrderResponse.fromCBJson({
        'order_total': '10.00',
        'max_leverage': '',
      });

      expect(preview.maxLeverage, isNull);
      expect(preview.leverage, isNull);
    });

    test('Edit preview totals keep precision a double would lose', () {
      final preview = EditOrderPreviewResponse.fromCBJson({
        'order_total': '61250.10',
        'commission_total': '0.45',
        'average_filled_price': '61250.10',
      });

      expect(preview.orderTotal! + preview.commissionTotal!,
          Decimal.parse('61250.55'));
      expect(preview.averageFilledPrice, Decimal.parse('61250.10'));
    });

    test('Order.fee and the Product 24h percentage changes are Decimal', () {
      final order = Order.fromCBJson({
        'order_id': '0000-000000-000000',
        'product_id': 'BTC-USD',
        'user_id': '2222-000000-000000',
        'side': 'BUY',
        'client_order_id': '11111-000000-000000',
        'status': 'FILLED',
        'time_in_force': 'IMMEDIATE_OR_CANCEL',
        'created_time': '2021-05-31T09:59:59Z',
        'order_configuration': {
          'market_market_ioc': {'quote_size': '25'}
        },
        'fee': '0.0000000028064',
        'total_fees': '0.50',
      });

      expect(order.fee, Decimal.parse('0.0000000028064'));
      expect(order.fee! + order.totalFees!, Decimal.parse('0.5000000028064'));

      // Coinbase sends an empty fee on orders that have not been billed.
      expect(
          Order.fromCBJson({
            'order_id': '0000-000000-000000',
            'product_id': 'BTC-USD',
            'user_id': '2222-000000-000000',
            'side': 'BUY',
            'client_order_id': '11111-000000-000000',
            'status': 'OPEN',
            'time_in_force': 'GOOD_UNTIL_CANCELLED',
            'created_time': '2021-05-31T09:59:59Z',
            'order_configuration': {
              'limit_limit_gtc': {'base_size': '0.001', 'limit_price': '10000'}
            },
            'fee': '',
          }).fee,
          isNull);

      final product = Product.fromCBJson({
        'product_id': 'BTC-USD',
        'price_percentage_change_24h': '-1.23456789',
        'volume_percentage_change_24h': '2.34',
      });

      // The sign survives, and so does every digit.
      expect(product.pricePercentageChange24h, Decimal.parse('-1.23456789'));
      expect(product.pricePercentageChange24h!.toString(), '-1.23456789');
      expect(product.volumePercentageChange24h, Decimal.parse('2.34'));

      final roundTripped = Product.fromJson(product.toJson());
      expect(roundTripped.pricePercentageChange24h,
          product.pricePercentageChange24h);
      expect(
          jsonDecode(jsonEncode(product.toJson()))['pricePercentageChange24h'],
          isA<String>());
    });
  });
}
