import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';

/// A representation of the server time.
class ServerTime {
  /// The time in ISO 8601 format.
  final DateTime? iso;

  /// The time in epoch seconds.
  final num? epochSeconds;

  /// The time in epoch milliseconds.
  final num? epochMillis;

  /// ServerTime constructor
  ServerTime(this.iso, this.epochSeconds, this.epochMillis);

  /// Creates a ServerTime from a Coinbase JSON object.
  factory ServerTime.fromCBJson(Map<String, dynamic> json) {
    return ServerTime(
      DateTime.parse(json['iso']),
      nullableNumber(json, 'epochSeconds'),
      nullableNumber(json, 'epochMillis'),
    );
  }

  @override
  String toString() {
    return 'ServerTime{iso: $iso, epochSeconds: $epochSeconds, epochMillis: $epochMillis}';
  }
}
