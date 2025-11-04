import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_pnl_configuration.dart';

class FuturesBalanceSummary {
  final Amount totalUsdBalance;
  final Amount unrealizedPnl;
  final Amount availableMargin;
  final Amount initialMargin;
  final Amount maintenanceMargin;
  final Amount positionNotional;
  final PnlConfiguration pnlConfiguration;
  final bool cfmFuturesEnabled;

  FuturesBalanceSummary(
      {required this.totalUsdBalance,
      required this.unrealizedPnl,
      required this.availableMargin,
      required this.initialMargin,
      required this.maintenanceMargin,
      required this.positionNotional,
      required this.pnlConfiguration,
      required this.cfmFuturesEnabled});

  factory FuturesBalanceSummary.fromCBJson(Map<String, dynamic> json) {
    return FuturesBalanceSummary(
      totalUsdBalance: Amount.fromCBJson(json['total_usd_balance']),
      unrealizedPnl: Amount.fromCBJson(json['unrealized_pnl']),
      availableMargin: Amount.fromCBJson(json['available_margin']),
      initialMargin: Amount.fromCBJson(json['initial_margin']),
      maintenanceMargin: Amount.fromCBJson(json['maintenance_margin']),
      positionNotional: Amount.fromCBJson(json['position_notional']),
      pnlConfiguration: PnlConfiguration.fromCBJson(json['pnl_configuration']),
      cfmFuturesEnabled: json['cfm_futures_enabled'],
    );
  }
}
