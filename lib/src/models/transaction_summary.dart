import 'package:coinbase_cloud_advanced_trade_client/src/models/fee_tier.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/goods_and_services_tax.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/volume_breakdown.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A representation of a transaction summary.
class TransactionSummary {
  /// The total volume.
  final Decimal totalVolume;

  /// The total fees.
  final Decimal totalFees;

  /// The fee tier.
  final FeeTier feeTier;

  /// The margin rate.
  final Decimal? marginRate;

  /// The goods and services tax.
  final GoodsAndServicesTax? goodsAndServicesTax;

  /// The advanced trade only volume.
  final Decimal advancedTradeOnlyVolume;

  /// The advanced trade only fees.
  final Decimal advancedTradeOnlyFees;

  /// The Coinbase Pro volume.
  final Decimal coinbaseProVolume;

  /// The Coinbase Pro fees.
  final Decimal coinbaseProFees;

  /// The total balance.
  final Decimal totalBalance;

  /// The volume breakdown.
  final List<VolumeBreakdown> volumeBreakdown;

  /// TransactionSummary constructor
  TransactionSummary(
      {required this.totalVolume,
      required this.totalFees,
      required this.feeTier,
      required this.marginRate,
      this.goodsAndServicesTax,
      required this.advancedTradeOnlyVolume,
      required this.advancedTradeOnlyFees,
      required this.coinbaseProVolume,
      required this.coinbaseProFees,
      required this.totalBalance,
      required this.volumeBreakdown});

  /// Creates a TransactionSummary from a Coinbase JSON object.
  factory TransactionSummary.fromCBJson(Map<String, dynamic> json) {
    var volumeBreakdown = <VolumeBreakdown>[];
    for (var volume in json['volume_breakdown']) {
      volumeBreakdown.add(VolumeBreakdown.fromCBJson(volume));
    }

    return TransactionSummary(
      totalVolume: requiredDecimal(json, 'total_volume', allowNum: true),
      totalFees: requiredDecimal(json, 'total_fees', allowNum: true),
      feeTier: FeeTier.fromCBJson(json['fee_tier']),
      marginRate: nullableDecimal(json, 'margin_rate', allowNum: true),
      goodsAndServicesTax: json['goods_and_services_tax'] != null
          ? GoodsAndServicesTax.fromCBJson(json['goods_and_services_tax'])
          : null,
      advancedTradeOnlyVolume:
          requiredDecimal(json, 'advanced_trade_only_volume', allowNum: true),
      advancedTradeOnlyFees:
          requiredDecimal(json, 'advanced_trade_only_fees', allowNum: true),
      coinbaseProVolume:
          requiredDecimal(json, 'coinbase_pro_volume', allowNum: true),
      coinbaseProFees:
          requiredDecimal(json, 'coinbase_pro_fees', allowNum: true),
      totalBalance: requiredDecimal(json, 'total_balance', allowNum: true),
      volumeBreakdown: volumeBreakdown,
    );
  }

  @override
  String toString() {
    return 'TransactionSummary{totalVolume: $totalVolume, totalFees: $totalFees, feeTier: $feeTier, marginRate: $marginRate, goodsAndServicesTax: $goodsAndServicesTax, advancedTradeOnlyVolume: $advancedTradeOnlyVolume, advancedTradeOnlyFees: $advancedTradeOnlyFees, coinbaseProVolume: $coinbaseProVolume, coinbaseProFees: $coinbaseProFees, totalBalance: $totalBalance, volumeBreakdown: $volumeBreakdown}';
  }
}
