/// A fee tier for a user.
class FeeTier {
  /// The pricing tier.
  final String pricingTier;

  /// The taker fee rate.
  final String takerFeeRate;

  /// The maker fee rate.
  final String makerFeeRate;

  /// The start of the average order price range.
  final String aopFrom;

  /// The end of the average order price range.
  final String aopTo;

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
      takerFeeRate: json['taker_fee_rate'],
      makerFeeRate: json['maker_fee_rate'],
      aopFrom: json['aop_from'],
      aopTo: json['aop_to'],
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
  final String volFrom;

  /// The end of the volume range.
  final String volTo;

  /// VolumeTypesAndRange constructor
  VolumeTypesAndRange(
      {required this.volumeTypes, required this.volFrom, required this.volTo});

  /// Creates a VolumeTypesAndRange from a Coinbase JSON object.
  factory VolumeTypesAndRange.fromCBJson(Map<String, dynamic> json) {
    return VolumeTypesAndRange(
      volumeTypes: List<String>.from(json['volume_types']),
      volFrom: json['vol_from'],
      volTo: json['vol_to'],
    );
  }

  @override
  String toString() {
    return 'VolumeTypesAndRange{volumeTypes: $volumeTypes, volFrom: $volFrom, volTo: $volTo}';
  }
}
