import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_error.dart';

/// Response from edit order preview request.
class EditOrderPreviewResponse {
  /// List of errors if any.
  final List<EditOrderError>? errors;

  /// The slippage of the order.
  final String? slippage;

  /// The total order amount.
  final String? orderTotal;

  /// The total commission.
  final String? commissionTotal;

  /// The size of the quote currency.
  final String? quoteSize;

  /// The size of the base currency.
  final String? baseSize;

  /// The best bid price.
  final String? bestBid;

  /// The best ask price.
  final String? bestAsk;

  /// The average filled price.
  final String? averageFilledPrice;

  /// Creates a new [EditOrderPreviewResponse] instance.
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

  /// Creates a new [EditOrderPreviewResponse] instance from a JSON map.
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
