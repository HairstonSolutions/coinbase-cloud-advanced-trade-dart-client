import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// Response from edit order preview request.
class EditOrderPreviewResponse {
  /// List of errors if any.
  final List<EditOrderError>? errors;

  /// The slippage of the order.
  final Decimal? slippage;

  /// The total order amount.
  final Decimal? orderTotal;

  /// The total commission.
  final Decimal? commissionTotal;

  /// The size of the quote currency.
  final Decimal? quoteSize;

  /// The size of the base currency.
  final Decimal? baseSize;

  /// The best bid price.
  final Decimal? bestBid;

  /// The best ask price.
  final Decimal? bestAsk;

  /// The average filled price.
  final Decimal? averageFilledPrice;

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
      slippage: nullableDecimal(json, 'slippage'),
      orderTotal: nullableDecimal(json, 'order_total'),
      commissionTotal: nullableDecimal(json, 'commission_total'),
      quoteSize: nullableDecimal(json, 'quote_size'),
      baseSize: nullableDecimal(json, 'base_size'),
      bestBid: nullableDecimal(json, 'best_bid'),
      bestAsk: nullableDecimal(json, 'best_ask'),
      averageFilledPrice: nullableDecimal(json, 'average_filled_price'),
    );
  }

  @override
  String toString() {
    return 'EditOrderPreviewResponse{errors: $errors, slippage: $slippage, orderTotal: $orderTotal, commissionTotal: $commissionTotal, quoteSize: $quoteSize, baseSize: $baseSize, bestBid: $bestBid, bestAsk: $bestAsk, averageFilledPrice: $averageFilledPrice}';
  }
}
