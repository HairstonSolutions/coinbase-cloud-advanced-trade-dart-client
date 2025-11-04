class VolumeBreakdown {
  final String volumeType;
  final double volume;

  VolumeBreakdown({required this.volumeType, required this.volume});

  factory VolumeBreakdown.fromCBJson(Map<String, dynamic> json) {
    return VolumeBreakdown(
      volumeType: json['volume_type'],
      volume: json['volume'],
    );
  }
}
