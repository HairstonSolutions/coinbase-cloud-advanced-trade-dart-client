import 'dart:convert';

import 'package:coinbase_cloud_exchange_dart_client/src/models/credential.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/models/fee.dart';
import 'package:coinbase_cloud_exchange_dart_client/src/services/network.dart';
import 'package:http/http.dart' as http;

Future<Fee> getFees(
    {required Credential credential, bool isSandbox = false}) async {
  late Fee fees;

  http.Response response = await getAuthorized('/Fees',
      credential: credential, isSandbox: isSandbox);

  if (response.statusCode == 200) {
    String data = response.body;
    var jsonResponse = jsonDecode(data);
    fees = convertFeesJson(jsonResponse);
  } else {
    var url = response.request?.url.toString();
    print('Request to URL $url failed.');
  }

  return fees;
}

Fee convertFeesJson(var jsonObject) {
  double? makerFeeRate = double.parse(jsonObject['maker_fee_rate']);
  double? takerFeeRate = double.parse(jsonObject['taker_fee_rate']);

  double? usdVolume = (jsonObject['usd_volume'] == null)
      ? 0.0
      : double.parse(jsonObject['usd_volume']);

  return Fee(makerFeeRate, takerFeeRate, usdVolume);
}
