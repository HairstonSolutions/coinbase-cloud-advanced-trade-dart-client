import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio_breakdown.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> money(String value) => {
        'value': value,
        'currency': 'USD',
      };

  Map<String, dynamic> currencyPair(String value) => {
        'userNativeCurrency': money(value),
        'rawCurrency': money(value),
      };

  group('Money', () {
    test('parses value as a Decimal', () {
      final parsed = Money.fromCBJson(money('61250.10'));

      expect(parsed.value, equals(Decimal.parse('61250.10')));
      expect(parsed.currency, equals('USD'));
    });

    test('throws FormatException on an unparsable value', () {
      expect(() => Money.fromCBJson(money('string')), throwsFormatException);
    });
  });

  group('PerpPosition', () {
    test('parses the sizes and rates as Decimal', () {
      final position = PerpPosition.fromCBJson({
        'product_id': 'BTC-PERP-INTX',
        'product_uuid': 'uuid',
        'symbol': 'BTC-PERP',
        'asset_image_url': 'https://example.com/btc.png',
        'vwap': {
          'userNativeCurrency': money('61700.00'),
          'rawCurrency': money('61700.00'),
        },
        'position_side': 'FUTURES_POSITION_SIDE_LONG',
        'net_size': '0.5',
        'buy_order_size': '0.1',
        'sell_order_size': '0.2',
        'im_contribution': '0.2',
        'unrealized_pnl': currencyPair('100.50'),
        'mark_price': currencyPair('61800.00'),
        'liquidation_price': currencyPair('50000.00'),
        'leverage': '3',
        'im_notional': currencyPair('10000.00'),
        'mm_notional': currencyPair('5000.00'),
        'position_notional': currencyPair('30850.00'),
        'margin_type': 'MARGIN_TYPE_CROSS',
        'liquidation_buffer': '11700.00',
        'liquidation_percentage': '0.19',
        'asset_color': '#F7931A',
      });

      expect(position.netSize, equals(Decimal.parse('0.5')));
      expect(position.buyOrderSize, equals(Decimal.parse('0.1')));
      expect(position.sellOrderSize, equals(Decimal.parse('0.2')));
      expect(position.imContribution, equals(Decimal.parse('0.2')));
      expect(position.leverage, equals(Decimal.parse('3')));
      expect(position.liquidationBuffer, equals(Decimal.parse('11700.00')));
      expect(position.liquidationPercentage, equals(Decimal.parse('0.19')));
      expect(
          position.vwap.rawCurrency.value, equals(Decimal.parse('61700.00')));
    });
  });

  group('FuturesPosition', () {
    test('parses the prices and sizes as Decimal', () {
      final position = FuturesPosition.fromCBJson({
        'product_id': 'BIT-26APR24-CDE',
        'contract_size': '0.01',
        'side': 'FUTURES_POSITION_SIDE_LONG',
        'amount': '2',
        'avg_entry_price': '61700.00',
        'current_price': '61800.00',
        'unrealized_pnl': '2.00',
        'expiry': '2024-04-26T00:00:00Z',
        'underlying_asset': 'BTC',
        'asset_img_url': 'https://example.com/btc.png',
        'product_name': 'BTC 26 APR 24',
        'venue': 'FCM',
        'notional_value': '1236.00',
        'asset_color': '#F7931A',
        'last_traded_at': '2024-04-01T00:00:00Z',
        'roll_date': '2024-04-19T00:00:00Z',
      });

      expect(position.contractSize, equals(Decimal.parse('0.01')));
      expect(position.amount, equals(Decimal.parse('2')));
      expect(position.avgEntryPrice, equals(Decimal.parse('61700.00')));
      expect(position.currentPrice, equals(Decimal.parse('61800.00')));
      expect(position.unrealizedPnl, equals(Decimal.parse('2.00')));
      expect(position.notionalValue, equals(Decimal.parse('1236.00')));

      // The position's move is exact arithmetic on the parsed values.
      expect(
          (position.currentPrice - position.avgEntryPrice) *
              position.contractSize *
              position.amount,
          equals(Decimal.parse('2.0000')));
    });
  });
}
