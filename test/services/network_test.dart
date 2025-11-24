import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import '../test_constants.dart' as constants;
import '../test_helpers.dart';

void main() {
  final Logger logger = setupLogger('network_test');

  group('Test Network Service', skip: constants.ciSkip, () {
    setUp(() {});

    test('Authorized Get with no body (Fees)', () async {
      String requestPath = "/transaction_summary";
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: false);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get to Accounts', () async {
      String requestPath = "/accounts";
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: true);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });

    test('Authorized Get to Sandbox Accounts', () async {
      String requestPath = "/accounts";
      var response = await getAuthorized(requestPath,
          credential: constants.credentials, isSandbox: true);
      var url = response.request?.url.toString();
      logger.info('Response Code: ${response.statusCode} to URL: $url');
      logger.info('Response body: ${response.body} to URL: $url');

      expect(response.statusCode == 200, isTrue);
    });
  });
}
