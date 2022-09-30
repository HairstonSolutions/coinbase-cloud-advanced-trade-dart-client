import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/models/product.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> getProducts({bool isSandbox = false}) async {
  List<Product> products = [];

  http.Response response = await get('/products', isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);

    for (var jsonObject in jsonResponse) {
      products.add(convertProductJson(jsonObject));
    }
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }

  return products;
}

Future<Product> getProduct(String tickerId, {bool isSandbox = false}) async {
  late Product product;

  http.Response response =
      await get('/products/$tickerId', isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    product = convertProductJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }

  return product;
}

Product convertProductJson(var jsonObject) {
  String id = jsonObject['id'];
  String? baseCurrency = jsonObject['base_currency'];
  String? quoteCurrency = jsonObject['quote_currency'];
  double? quoteIncrement = double.parse(jsonObject['quote_increment']);
  double? baseIncrement = double.parse(jsonObject['base_increment']);
  String? displayName = jsonObject['display_name'];
  double? minMarketFunds = double.parse(jsonObject['min_market_funds']);
  bool marginEnabled = jsonObject['margin_enabled'];
  bool postOnly = jsonObject['post_only'];
  bool limitOnly = jsonObject['limit_only'];
  bool cancelOnly = jsonObject['cancel_only'];
  String? status = jsonObject['status'];
  String? statusMessage = jsonObject['status_message'];
  bool tradingDisabled = jsonObject['trading_disabled'];
  bool fxStablecoin = jsonObject['fx_stablecoin'];
  double? maxSlippagePercentage =
      double.parse(jsonObject['max_slippage_percentage']);
  bool auctionMode = jsonObject['auction_mode'];

  return Product(
      id,
      baseCurrency,
      quoteCurrency,
      quoteIncrement,
      baseIncrement,
      displayName,
      minMarketFunds,
      marginEnabled,
      postOnly,
      limitOnly,
      cancelOnly,
      status,
      statusMessage,
      tradingDisabled,
      fxStablecoin,
      maxSlippagePercentage,
      auctionMode);
}
