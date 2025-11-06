import 'package:coinbase_cloud_advanced_trade_client/advanced_trade.dart';

class ServerTime {
  final DateTime? iso;
  final num? epochSeconds;
  final num? epochMillis;

  ServerTime(this.iso, this.epochSeconds, this.epochMillis);

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
