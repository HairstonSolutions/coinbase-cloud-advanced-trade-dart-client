import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';
import 'package:decimal/decimal.dart';

/// A representation of a volume breakdown.
class VolumeBreakdown {
  /// The type of volume.
  final String volumeType;

  /// The volume.
  final Decimal volume;

  /// VolumeBreakdown constructor
  VolumeBreakdown({required this.volumeType, required this.volume});

  /// Creates a VolumeBreakdown from a Coinbase JSON object.
  factory VolumeBreakdown.fromCBJson(Map<String, dynamic> json) {
    return VolumeBreakdown(
      volumeType: json['volume_type'],
      volume: requiredDecimal(json, 'volume'),
    );
  }

  @override
  String toString() {
    return 'VolumeBreakdown{volumeType: $volumeType, volume: $volume}';
  }
}
