import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/order_side.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/preview_order.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/rest/orders/orders.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../tools.dart';
import 'preview_order_test.mocks.dart';
import 'package:logging/logging.dart';

import '../../test_constants.dart';

final Logger _logger = Logger('PreviewOrderTest');

@GenerateMocks([http.Client])
void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  group('Preview Order', () {
    test('previews a market order', () async {
      final mockClient = MockClient();
      final successResponse =
          await getJsonFromFile('mocks/rest/orders/preview_order_success.json');

      when(mockClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(successResponse, 200));

      final PreviewOrderResponse previewOrderResponse = await previewOrder(
          client: mockClient,
          credential: credentials,
          productId: 'BTC-USD',
          side: OrderSide.buy,
          orderConfiguration: {
            'market_market_ioc': {'quote_size': '10'}
          });

      expect(previewOrderResponse, isNotNull);
      expect(previewOrderResponse.orderTotal, '10.00');
      expect(previewOrderResponse.commissionTotal, '0.05');
      expect(previewOrderResponse.quoteSize, 10.00);
      expect(previewOrderResponse.baseSize, 0.001);
      expect(previewOrderResponse.bestBid, '9999.00');
      expect(previewOrderResponse.bestAsk, '10001.00');
      expect(previewOrderResponse.previewId, 'PREVIEW-ID-12345');
    });
  });

  group('Preview Order Integration', () {
    test('previews a market order', () async {
      final PreviewOrderResponse previewOrderResponse = await previewOrder(
          credential: credentials,
          productId: 'BTC-USD',
          side: OrderSide.buy,
          orderConfiguration: {
            'market_market_ioc': {'quote_size': '10'}
          });

      _logger.info(previewOrderResponse.toString());
      expect(previewOrderResponse, isNotNull);
      expect(previewOrderResponse.orderTotal, isNotNull);
    }, skip: ciSkip);
  });
}
