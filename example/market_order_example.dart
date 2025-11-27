import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';

final Map<String, String> envVars = Platform.environment;
final String? apiKeyName = envVars['COINBASE_API_KEY_NAME'];
final String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];

// This is a simple example of how to use the market order API.
//
// To run this example, you will need to create a `Credential` object with your
// API key and secret. You can get these from the Coinbase Advanced Trade API
// website.
//
// https://docs.cdp.coinbase.com/advanced-trade/docs/welcome/
//
// Make sure to set the COINBASE_API_KEY_NAME and COINBASE_PRIVATE_KEY
// environment variables before running this example.
//
// This example will create a market order for BTC-USD for $10 USD.
void main() async {
  // Check that the API key and secret are set.
  if (apiKeyName == null || privateKeyPEM == null) {
    print('Please set the COINBASE_API_KEY_NAME and COINBASE_PRIVATE_KEY '
        'environment variables.');
    return;
  }

  // Create a Credential object with your API key and secret.
  final credential = Credential(
    apiKeyName: apiKeyName!,
    privateKeyPEM: privateKeyPEM!,
  );

  // Create a market order.
  final result = await createMarketOrder(
    clientOrderId: 'test-order-123',
    productId: 'BTC-USD',
    side: OrderSide.buy,
    quoteSize: '10',
    credential: credential,
  );

  // Print the result to the console.
  print(result);
}
