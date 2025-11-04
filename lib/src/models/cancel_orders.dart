import 'package:coinbase_cloud_advanced_trade_client/src/models/cancel_order_result.dart';

class CancelOrders {
  final List<CancelOrderResult> results;

  CancelOrders(this.results);

  factory CancelOrders.fromCBJson(Map<String, dynamic> json) {
    var results = <CancelOrderResult>[];
    for (var result in json['results']) {
      results.add(CancelOrderResult.fromCBJson(result));
    }

    return CancelOrders(results);
  }
}
