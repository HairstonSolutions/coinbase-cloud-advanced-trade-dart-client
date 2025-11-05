import 'package:coinbase_cloud_advanced_trade_client/src/models/fee_tier.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/goods_and_services_tax.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/volume_breakdown.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

class TransactionSummary {
  final num totalVolume;
  final num totalFees;
  final FeeTier feeTier;
  final num? marginRate;
  final GoodsAndServicesTax? goodsAndServicesTax;
  final num advancedTradeOnlyVolume;
  final num advancedTradeOnlyFees;
  final num coinbaseProVolume;
  final num coinbaseProFees;
  final String totalBalance;
  final List<VolumeBreakdown> volumeBreakdown;

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

  factory TransactionSummary.fromCBJson(Map<String, dynamic> json) {
    var volumeBreakdown = <VolumeBreakdown>[];
    for (var volume in json['volume_breakdown']) {
      volumeBreakdown.add(VolumeBreakdown.fromCBJson(volume));
    }

    return TransactionSummary(
      totalVolume: json['total_volume'],
      totalFees: json['total_fees'],
      feeTier: FeeTier.fromCBJson(json['fee_tier']),
      marginRate: nullableNumber(json, 'margin_rate'),
      goodsAndServicesTax: json['goods_and_services_tax'] != null
          ? GoodsAndServicesTax.fromCBJson(json['goods_and_services_tax'])
          : null,
      advancedTradeOnlyVolume: json['advanced_trade_only_volume'],
      advancedTradeOnlyFees: json['advanced_trade_only_fees'],
      coinbaseProVolume: json['coinbase_pro_volume'],
      coinbaseProFees: json['coinbase_pro_fees'],
      totalBalance: json['total_balance'],
      volumeBreakdown: volumeBreakdown,
    );
  }

  @override
  String toString() {
    return 'TransactionSummary{totalVolume: $totalVolume, totalFees: $totalFees, feeTier: $feeTier, marginRate: $marginRate, goodsAndServicesTax: $goodsAndServicesTax, advancedTradeOnlyVolume: $advancedTradeOnlyVolume, advancedTradeOnlyFees: $advancedTradeOnlyFees, coinbaseProVolume: $coinbaseProVolume, coinbaseProFees: $coinbaseProFees, totalBalance: $totalBalance, volumeBreakdown: $volumeBreakdown}';
  }
}
