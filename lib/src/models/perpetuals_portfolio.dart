import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';

class PerpetualsPortfolio {
  final String portfolioUuid;
  final String collateral;
  final String positionNotional;
  final String openPositionNotional;
  final String pendingFees;
  final String borrow;
  final String accruedInterest;
  final String rollingDebt;
  final String portfolioInitialMargin;
  final Amount portfolioImNotional;
  final String portfolioMaintenanceMargin;
  final Amount portfolioMmNotional;
  final String liquidationPercentage;
  final String liquidationBuffer;
  final String marginType;
  final String marginFlags;
  final String liquidationStatus;
  final Amount unrealizedPnl;
  final Amount totalBalance;

  PerpetualsPortfolio(
      {required this.portfolioUuid,
      required this.collateral,
      required this.positionNotional,
      required this.openPositionNotional,
      required this.pendingFees,
      required this.borrow,
      required this.accruedInterest,
      required this.rollingDebt,
      required this.portfolioInitialMargin,
      required this.portfolioImNotional,
      required this.portfolioMaintenanceMargin,
      required this.portfolioMmNotional,
      required this.liquidationPercentage,
      required this.liquidationBuffer,
      required this.marginType,
      required this.marginFlags,
      required this.liquidationStatus,
      required this.unrealizedPnl,
      required this.totalBalance});

  factory PerpetualsPortfolio.fromCBJson(Map<String, dynamic> json) {
    return PerpetualsPortfolio(
      portfolioUuid: json['portfolio_uuid'],
      collateral: json['collateral'],
      positionNotional: json['position_notional'],
      openPositionNotional: json['open_position_notional'],
      pendingFees: json['pending_fees'],
      borrow: json['borrow'],
      accruedInterest: json['accrued_interest'],
      rollingDebt: json['rolling_debt'],
      portfolioInitialMargin: json['portfolio_initial_margin'],
      portfolioImNotional: Amount.fromCBJson(json['portfolio_im_notional']),
      portfolioMaintenanceMargin: json['portfolio_maintenance_margin'],
      portfolioMmNotional: Amount.fromCBJson(json['portfolio_mm_notional']),
      liquidationPercentage: json['liquidation_percentage'],
      liquidationBuffer: json['liquidation_buffer'],
      marginType: json['margin_type'],
      marginFlags: json['margin_flags'],
      liquidationStatus: json['liquidation_status'],
      unrealizedPnl: Amount.fromCBJson(json['unrealized_pnl']),
      totalBalance: Amount.fromCBJson(json['total_balance']),
    );
  }
}
