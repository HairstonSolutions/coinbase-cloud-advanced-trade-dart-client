import 'package:coinbase_cloud_advanced_trade_client/src/models/commission_detail_total.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/compliance_limit_data.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/margin_ratio_data.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/pnl_configuration.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/scaled_metadata.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/twap_bucket_metadata.dart';

class PreviewOrder {
  final String orderTotal;
  final String commissionTotal;
  final List<String> errs;
  final List<String> warning;
  final double quoteSize;
  final double baseSize;
  final String bestBid;
  final String bestAsk;
  final bool isMax;
  final String orderMarginTotal;
  final String leverage;
  final String longLeverage;
  final String shortLeverage;
  final String slippage;
  final String previewId;
  final String currentLiquidationBuffer;
  final String projectedLiquidationBuffer;
  final String maxLeverage;
  final PnlConfiguration? pnlConfiguration;
  final TwapBucketMetadata? twapBucketMetadata;
  final String positionNotionalLimit;
  final String maxNotionalAtRequestedLeverage;
  final MarginRatioData? marginRatioData;
  final CommissionDetailTotal? commissionDetailTotal;
  final ScaledMetadata? scaledMetadata;
  final ComplianceLimitData? complianceLimitData;
  final String estAverageFilledPrice;

  PreviewOrder(
      {required this.orderTotal,
      required this.commissionTotal,
      required this.errs,
      required this.warning,
      required this.quoteSize,
      required this.baseSize,
      required this.bestBid,
      required this.bestAsk,
      required this.isMax,
      required this.orderMarginTotal,
      required this.leverage,
      required this.longLeverage,
      required this.shortLeverage,
      required this.slippage,
      required this.previewId,
      required this.currentLiquidationBuffer,
      required this.projectedLiquidationBuffer,
      required this.maxLeverage,
      this.pnlConfiguration,
      this.twapBucketMetadata,
      required this.positionNotionalLimit,
      required this.maxNotionalAtRequestedLeverage,
      this.marginRatioData,
      this.commissionDetailTotal,
      this.scaledMetadata,
      this.complianceLimitData,
      required this.estAverageFilledPrice});

  factory PreviewOrder.fromCBJson(Map<String, dynamic> json) {
    return PreviewOrder(
      orderTotal: json['order_total'],
      commissionTotal: json['commission_total'],
      errs: List<String>.from(json['errs']),
      warning: List<String>.from(json['warning']),
      quoteSize: json['quote_size'],
      baseSize: json['base_size'],
      bestBid: json['best_bid'],
      bestAsk: json['best_ask'],
      isMax: json['is_max'],
      orderMarginTotal: json['order_margin_total'],
      leverage: json['leverage'],
      longLeverage: json['long_leverage'],
      shortLeverage: json['short_leverage'],
      slippage: json['slippage'],
      previewId: json['preview_id'],
      currentLiquidationBuffer: json['current_liquidation_buffer'],
      projectedLiquidationBuffer: json['projected_liquidation_buffer'],
      maxLeverage: json['max_leverage'],
      pnlConfiguration: json['pnl_configuration'] != null
          ? PnlConfiguration.fromCBJson(json['pnl_configuration'])
          : null,
      twapBucketMetadata: json['twap_bucket_metadata'] != null
          ? TwapBucketMetadata.fromCBJson(json['twap_bucket_metadata'])
          : null,
      positionNotionalLimit: json['position_notional_limit'],
      maxNotionalAtRequestedLeverage:
          json['max_notional_at_requested_leverage'],
      marginRatioData: json['margin_ratio_data'] != null
          ? MarginRatioData.fromCBJson(json['margin_ratio_data'])
          : null,
      commissionDetailTotal: json['commission_detail_total'] != null
          ? CommissionDetailTotal.fromCBJson(json['commission_detail_total'])
          : null,
      scaledMetadata: json['scaled_metadata'] != null
          ? ScaledMetadata.fromCBJson(json['scaled_metadata'])
          : null,
      complianceLimitData: json['compliance_limit_data'] != null
          ? ComplianceLimitData.fromCBJson(json['compliance_limit_data'])
          : null,
      estAverageFilledPrice: json['est_average_filled_price'],
    );
  }
}
