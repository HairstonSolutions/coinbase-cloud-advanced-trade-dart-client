import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';

class FuturesSweep {
  final String id;
  final Amount requestedAmount;
  final bool shouldSweepAll;
  final String status;
  final String scheduledTime;

  FuturesSweep(
      {required this.id,
      required this.requestedAmount,
      required this.shouldSweepAll,
      required this.status,
      required this.scheduledTime});

  factory FuturesSweep.fromCBJson(Map<String, dynamic> json) {
    return FuturesSweep(
      id: json['id'],
      requestedAmount: Amount.fromCBJson(json['requested_amount']),
      shouldSweepAll: json['should_sweep_all'],
      status: json['status'],
      scheduledTime: json['scheduled_time'],
    );
  }
}
