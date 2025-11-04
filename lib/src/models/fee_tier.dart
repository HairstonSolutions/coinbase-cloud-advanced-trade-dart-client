class FeeTier {
  final String pricingTier;
  final String takerFeeRate;
  final String makerFeeRate;
  final String aopFrom;
  final String aopTo;
  final List<VolumeTypesAndRange> volumeTypesAndRange;

  FeeTier(
      {required this.pricingTier,
      required this.takerFeeRate,
      required this.makerFeeRate,
      required this.aopFrom,
      required this.aopTo,
      required this.volumeTypesAndRange});

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
}

class VolumeTypesAndRange {
  final List<String> volumeTypes;
  final String volFrom;
  final String volTo;

  VolumeTypesAndRange(
      {required this.volumeTypes, required this.volFrom, required this.volTo});

  factory VolumeTypesAndRange.fromCBJson(Map<String, dynamic> json) {
    return VolumeTypesAndRange(
      volumeTypes: List<String>.from(json['volume_types']),
      volFrom: json['vol_from'],
      volTo: json['vol_to'],
    );
  }
}
