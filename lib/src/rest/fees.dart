import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/models/credential.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/transaction_summary.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/network.dart';
import 'package:http/http.dart' as http;

/// Gets the transaction summary.
///
/// GET /api/v3/brokerage/transaction_summary
/// https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/fees/get-transaction-summary
///
/// [productType] - The type of product to get the summary for.
/// [contractExpiryType] - The contract expiry type.
/// [productVenue] - The product venue.
/// [credential] - The user's API credentials.
/// [isSandbox] - Whether to use the sandbox environment.
///
/// Returns a [TransactionSummary] object.
Future<TransactionSummary?> getTransactionSummary(
    {String? productType,
    String? contractExpiryType,
    String? productVenue,
    http.Client? client,
    required Credential credential,
    bool isSandbox = false}) async {
  Map<String, dynamic> queryParameters = {};
  if (productType != null) {
    queryParameters.addAll({'product_type': productType});
  }
  if (contractExpiryType != null) {
    queryParameters.addAll({'contract_expiry_type': contractExpiryType});
  }
  if (productVenue != null) {
    queryParameters.addAll({'product_venue': productVenue});
  }

  http.Response response = await getAuthorized('/transaction_summary',
      queryParameters: queryParameters,
      client: client,
      credential: credential,
      isSandbox: isSandbox);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return TransactionSummary.fromCBJson(jsonResponse);
  } else {
    throw CoinbaseException(
        'Failed to get transaction summary', response.statusCode, response.body);
  }
}
