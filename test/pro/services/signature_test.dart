import 'package:coinbase_cloud_advanced_trade_client/src/pro/services/signature.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/shared/models/signature.dart';
import 'package:test/test.dart';

void main() {
  group('Test Signature', () {
    setUp(() {});

    test('Get Orders Signature', () {
      String secret = "secretPlaceholder123";
      String httpMethod = "GET";
      String requestPath = "/orders";
      String body = "?sortedBy=created_at&sorting=desc&limit=100&status=open";
      Signature mySignature = signature(secret, httpMethod, requestPath, body);
      print('Signature: $mySignature');

      expect(mySignature.signature.length > 30, true);
    });
  });
}
