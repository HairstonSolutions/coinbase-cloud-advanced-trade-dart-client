import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A fee tier for a user.
class FeeTier {
  /// The pricing tier.
  final String pricingTier;

  /// The taker fee rate.
  final Decimal takerFeeRate;

  /// The maker fee rate.
  final Decimal makerFeeRate;

  /// The start of the average order price range.
  final Decimal aopFrom;

  /// The end of the average order price range, or null when the tier is
  /// unbounded above. Coinbase sends an empty string for the highest tier.
  final Decimal? aopTo;

  /// The volume types and ranges.
  final List<VolumeTypesAndRange> volumeTypesAndRange;

  /// FeeTier constructor
  FeeTier(
      {required this.pricingTier,
      required this.takerFeeRate,
      required this.makerFeeRate,
      required this.aopFrom,
      required this.aopTo,
      required this.volumeTypesAndRange});

  /// Creates a FeeTier from a Coinbase JSON object.
  factory FeeTier.fromCBJson(Map<String, dynamic> json) {
    var volumeTypesAndRange = <VolumeTypesAndRange>[];
    for (var volume in json['volume_types_and_range']) {
      volumeTypesAndRange.add(VolumeTypesAndRange.fromCBJson(volume));
    }

    return FeeTier(
      pricingTier: json['pricing_tier'],
      takerFeeRate: requiredDecimal(json, 'taker_fee_rate', allowNum: true),
      makerFeeRate: requiredDecimal(json, 'maker_fee_rate', allowNum: true),
      aopFrom: requiredDecimal(json, 'aop_from', allowNum: true),
      aopTo: nullableDecimal(json, 'aop_to', allowNum: true),
      volumeTypesAndRange: volumeTypesAndRange,
    );
  }

  @override
  String toString() {
    return 'FeeTier{pricingTier: $pricingTier, takerFeeRate: $takerFeeRate, makerFeeRate: $makerFeeRate, aopFrom: $aopFrom, aopTo: $aopTo, volumeTypesAndRange: $volumeTypesAndRange}';
  }
}

/// A volume type and range.
class VolumeTypesAndRange {
  /// The volume types.
  final List<String> volumeTypes;

  /// The start of the volume range.
  final Decimal volFrom;

  /// The end of the volume range, or null when the range is unbounded above.
  /// Coinbase sends an empty string for the highest tier.
  final Decimal? volTo;

  /// VolumeTypesAndRange constructor
  VolumeTypesAndRange(
      {required this.volumeTypes, required this.volFrom, required this.volTo});

  /// Creates a VolumeTypesAndRange from a Coinbase JSON object.
  factory VolumeTypesAndRange.fromCBJson(Map<String, dynamic> json) {
    return VolumeTypesAndRange(
      volumeTypes: List<String>.from(json['volume_types']),
      volFrom: requiredDecimal(json, 'vol_from', allowNum: true),
      volTo: nullableDecimal(json, 'vol_to', allowNum: true),
    );
  }

  @override
  String toString() {
    return 'VolumeTypesAndRange{volumeTypes: $volumeTypes, volFrom: $volFrom, volTo: $volTo}';
  }
}
