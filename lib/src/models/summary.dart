import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';

class Summary {
  final Amount unrealizedPnl;
  final Amount buyingPower;
  final Amount totalBalance;
  final Amount maxWithdrawalAmount;

  Summary(
      {required this.unrealizedPnl,
      required this.buyingPower,
      required this.totalBalance,
      required this.maxWithdrawalAmount});

  factory Summary.fromCBJson(Map<String, dynamic> json) {
    return Summary(
      unrealizedPnl: Amount.fromCBJson(json['unrealized_pnl']),
      buyingPower: Amount.fromCBJson(json['buying_power']),
      totalBalance: Amount.fromCBJson(json['total_balance']),
      maxWithdrawalAmount: Amount.fromCBJson(json['max_withdrawal_amount']),
    );
  }
}
