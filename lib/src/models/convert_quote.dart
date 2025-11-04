import 'package:coinbase_cloud_advanced_trade_client/src/models/convert_trade.dart';

class ConvertQuote {
  final ConvertTrade trade;

  ConvertQuote({required this.trade});

  factory ConvertQuote.fromCBJson(Map<String, dynamic> json) {
    return ConvertQuote(
      trade: ConvertTrade.fromCBJson(json['trade']),
    );
  }
}
