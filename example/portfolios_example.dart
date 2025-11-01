import 'dart:io' show Platform;

import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/models/portfolio.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/advanced_trade/rest/portfolios.dart';

final Map<String, String> envVars = Platform.environment;
final String apiKeyName = envVars['COINBASE_API_KEY_NAME'] ?? 'api_key_name';
final String? privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'];

// This is a simple example of how to use the portfolios API.
//
// To run this example, you will need to create a `Credential` object with your
// API key and secret. You can get these from the Coinbase Advanced Trade API
// website.
//
// https://docs.cdp.coinbase.com/advanced-trade/docs/welcome/
//
// This example will list all of your portfolios and print them to the console.
void main() async {
  // Create a Credential object with your API key and secret.
  //
  // You can get these from the Coinbase Advanced Trade API website.
  //
  // Make sure to replace the placeholder values with your actual API key and
  // secret.
  final credential = Credential(
    apiKeyName: apiKeyName,
    privateKeyPEM: privateKeyPEM!,
  );

  // List all portfolios.
  final List<Portfolio> portfolios = await listPortfolios(
    credential: credential,
  );

  // Print the portfolios to the console.
  for (final portfolio in portfolios) {
    print('Portfolio ID: ${portfolio.uuid}');
    print('Portfolio Name: ${portfolio.name}');
    print('---');
  }
}
