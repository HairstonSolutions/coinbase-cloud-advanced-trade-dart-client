import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_error.dart';

class EditOrderPreviewResponse {
  final List<EditOrderError>? errors;
  final String? slippage;
  final String? orderTotal;
  final String? commissionTotal;
  final String? quoteSize;
  final String? baseSize;
  final String? bestBid;
  final String? bestAsk;
  final String? averageFilledPrice;

  EditOrderPreviewResponse({
    this.errors,
    this.slippage,
    this.orderTotal,
    this.commissionTotal,
    this.quoteSize,
    this.baseSize,
    this.bestBid,
    this.bestAsk,
    this.averageFilledPrice,
  });

  factory EditOrderPreviewResponse.fromCBJson(Map<String, dynamic> json) {
    return EditOrderPreviewResponse(
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => EditOrderError.fromCBJson(e as Map<String, dynamic>))
          .toList(),
      slippage: json['slippage'],
      orderTotal: json['order_total'],
      commissionTotal: json['commission_total'],
      quoteSize: json['quote_size'],
      baseSize: json['base_size'],
      bestBid: json['best_bid'],
      bestAsk: json['best_ask'],
      averageFilledPrice: json['average_filled_price'],
    );
  }

  @override
  String toString() {
    return '''EditOrderPreviewResponse{
      errors: $errors,
      slippage: $slippage,
      orderTotal: $orderTotal,
      commissionTotal: $commissionTotal,
      quoteSize: $quoteSize,
      baseSize: $baseSize,
      bestBid: $bestBid,
      bestAsk: $bestAsk,
      averageFilledPrice: $averageFilledPrice
    }''';
  }
}
