/// A representation of a volume breakdown.
class VolumeBreakdown {
  /// The type of volume.
  final String volumeType;

  /// The volume.
  final num volume;

  /// VolumeBreakdown constructor
  VolumeBreakdown({required this.volumeType, required this.volume});

  /// Creates a VolumeBreakdown from a Coinbase JSON object.
  factory VolumeBreakdown.fromCBJson(Map<String, dynamic> json) {
    return VolumeBreakdown(
      volumeType: json['volume_type'],
      volume: json['volume'],
    );
  }

  @override
  String toString() {
    return 'VolumeBreakdown{volumeType: $volumeType, volume: $volume}';
  }
}
