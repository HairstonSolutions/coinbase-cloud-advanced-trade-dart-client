import 'package:coinbase_cloud_advanced_trade_client/src/models/commission_detail_total.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/edit_order_error.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/pnl_configuration.dart';

class EditPreviewOrder {
  final List<EditOrderError> errors;
  final String slippage;
  final String orderTotal;
  final String commissionTotal;
  final double quoteSize;
  final double baseSize;
  final String bestBid;
  final String bestAsk;
  final String averageFilledPrice;
  final String orderMarginTotal;
  final CommissionDetailTotal? commissionDetailTotal;
  final PnlConfiguration? pnlConfiguration;

  EditPreviewOrder(
      {required this.errors,
      required this.slippage,
      required this.orderTotal,
      required this.commissionTotal,
      required this.quoteSize,
      required this.baseSize,
      required this.bestBid,
      required this.bestAsk,
      required this.averageFilledPrice,
      required this.orderMarginTotal,
      this.commissionDetailTotal,
      this.pnlConfiguration});

  factory EditPreviewOrder.fromCBJson(Map<String, dynamic> json) {
    var errors = <EditOrderError>[];
    for (var error in json['errors']) {
      errors.add(EditOrderError.fromCBJson(error));
    }

    return EditPreviewOrder(
      errors: errors,
      slippage: json['slippage'],
      orderTotal: json['order_total'],
      commissionTotal: json['commission_total'],
      quoteSize: json['quote_size'],
      baseSize: json['base_size'],
      bestBid: json['best_bid'],
      bestAsk: json['best_ask'],
      averageFilledPrice: json['average_filled_price'],
      orderMarginTotal: json['order_margin_total'],
      commissionDetailTotal: json['commission_detail_total'] != null
          ? CommissionDetailTotal.fromCBJson(json['commission_detail_total'])
          : null,
      pnlConfiguration: json['pnl_configuration'] != null
          ? PnlConfiguration.fromCBJson(json['pnl_configuration'])
          : null,
    );
  }
}
