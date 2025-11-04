import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/fee.dart';

class ConvertTrade {
  final String id;
  final String status;
  final Amount userEnteredAmount;
  final Amount amount;
  final Amount subtotal;
  final Amount total;
  final List<Fee> fees;
  final Fee totalFee;
  final Map<String, dynamic> source;
  final Map<String, dynamic> target;

  ConvertTrade(
      {required this.id,
      required this.status,
      required this.userEnteredAmount,
      required this.amount,
      required this.subtotal,
      required this.total,
      required this.fees,
      required this.totalFee,
      required this.source,
      required this.target});

  factory ConvertTrade.fromCBJson(Map<String, dynamic> json) {
    var fees = <Fee>[];
    for (var fee in json['fees']) {
      fees.add(Fee.fromCBJson(fee));
    }

    return ConvertTrade(
      id: json['id'],
      status: json['status'],
      userEnteredAmount: Amount.fromJson(json['user_entered_amount']),
      amount: Amount.fromJson(json['amount']),
      subtotal: Amount.fromJson(json['subtotal']),
      total: Amount.fromJson(json['total']),
      fees: fees,
      totalFee: Fee.fromCBJson(json['total_fee']),
      source: json['source'],
      target: json['target'],
    );
  }
}
