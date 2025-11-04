// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perpetuals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerpetualsPortfolioSummary _$PerpetualsPortfolioSummaryFromJson(
        Map<String, dynamic> json) =>
    PerpetualsPortfolioSummary(
      totalAccountValue:
          Amount.fromJson(json['total_account_value'] as Map<String, dynamic>),
      totalMargin:
          Amount.fromJson(json['total_margin'] as Map<String, dynamic>),
      availableMargin:
          Amount.fromJson(json['available_margin'] as Map<String, dynamic>),
      initialMargin:
          Amount.fromJson(json['initial_margin'] as Map<String, dynamic>),
      maintenanceMargin:
          Amount.fromJson(json['maintenance_margin'] as Map<String, dynamic>),
      totalPnl: Amount.fromJson(json['total_pnl'] as Map<String, dynamic>),
      portfolioIm:
          Amount.fromJson(json['portfolio_im'] as Map<String, dynamic>),
      portfolioMm:
          Amount.fromJson(json['portfolio_mm'] as Map<String, dynamic>),
      portfolioUuid: json['portfolio_uuid'] as String,
      collateralCurrency: json['collateral_currency'] as String,
      collaterals: (json['collaterals'] as List<dynamic>)
          .map((e) => Collateral.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PerpetualsPortfolioSummaryToJson(
        PerpetualsPortfolioSummary instance) =>
    <String, dynamic>{
      'total_account_value': instance.totalAccountValue,
      'total_margin': instance.totalMargin,
      'available_margin': instance.availableMargin,
      'initial_margin': instance.initialMargin,
      'maintenance_margin': instance.maintenanceMargin,
      'total_pnl': instance.totalPnl,
      'portfolio_im': instance.portfolioIm,
      'portfolio_mm': instance.portfolioMm,
      'portfolio_uuid': instance.portfolioUuid,
      'collateral_currency': instance.collateralCurrency,
      'collaterals': instance.collaterals,
    };

Collateral _$CollateralFromJson(Map<String, dynamic> json) => Collateral(
      assetName: json['asset_name'] as String,
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>),
      haircut: json['haircut'] as String,
      collateralValue: json['collateral_value'] as String,
    );

Map<String, dynamic> _$CollateralToJson(Collateral instance) =>
    <String, dynamic>{
      'asset_name': instance.assetName,
      'amount': instance.amount,
      'haircut': instance.haircut,
      'collateral_value': instance.collateralValue,
    };

PerpetualsPositions _$PerpetualsPositionsFromJson(Map<String, dynamic> json) =>
    PerpetualsPositions(
      positions: (json['positions'] as List<dynamic>)
          .map((e) => PerpetualsPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: PerpetualsPositionsSummary.fromJson(
          json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PerpetualsPositionsToJson(
        PerpetualsPositions instance) =>
    <String, dynamic>{
      'positions': instance.positions,
      'summary': instance.summary,
    };

PerpetualsPosition _$PerpetualsPositionFromJson(Map<String, dynamic> json) =>
    PerpetualsPosition(
      productId: json['product_id'] as String,
      productUuid: json['product_uuid'] as String,
      portfolioUuid: json['portfolio_uuid'] as String,
      symbol: json['symbol'] as String,
      vwap: Amount.fromJson(json['vwap'] as Map<String, dynamic>),
      entryVwap: Amount.fromJson(json['entry_vwap'] as Map<String, dynamic>),
      positionSide: json['position_side'] as String,
      marginType: json['margin_type'] as String,
      netSize: json['net_size'] as String,
      buyOrderSize: json['buy_order_size'] as String,
      sellOrderSize: json['sell_order_size'] as String,
      imContribution: json['im_contribution'] as String,
      unrealizedPnl:
          Amount.fromJson(json['unrealized_pnl'] as Map<String, dynamic>),
      markPrice: Amount.fromJson(json['mark_price'] as Map<String, dynamic>),
      liquidationPrice:
          Amount.fromJson(json['liquidation_price'] as Map<String, dynamic>),
      leverage: json['leverage'] as String,
      imNotional: Amount.fromJson(json['im_notional'] as Map<String, dynamic>),
      mmNotional: Amount.fromJson(json['mm_notional'] as Map<String, dynamic>),
      positionNotional:
          Amount.fromJson(json['position_notional'] as Map<String, dynamic>),
      aggregatedPnl:
          Amount.fromJson(json['aggregated_pnl'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PerpetualsPositionToJson(PerpetualsPosition instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_uuid': instance.productUuid,
      'portfolio_uuid': instance.portfolioUuid,
      'symbol': instance.symbol,
      'vwap': instance.vwap,
      'entry_vwap': instance.entryVwap,
      'position_side': instance.positionSide,
      'margin_type': instance.marginType,
      'net_size': instance.netSize,
      'buy_order_size': instance.buyOrderSize,
      'sell_order_size': instance.sellOrderSize,
      'im_contribution': instance.imContribution,
      'unrealized_pnl': instance.unrealizedPnl,
      'mark_price': instance.markPrice,
      'liquidation_price': instance.liquidationPrice,
      'leverage': instance.leverage,
      'im_notional': instance.imNotional,
      'mm_notional': instance.mmNotional,
      'position_notional': instance.positionNotional,
      'aggregated_pnl': instance.aggregatedPnl,
    };

PerpetualsPositionsSummary _$PerpetualsPositionsSummaryFromJson(
        Map<String, dynamic> json) =>
    PerpetualsPositionsSummary(
      aggregatedPnl:
          Amount.fromJson(json['aggregated_pnl'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PerpetualsPositionsSummaryToJson(
        PerpetualsPositionsSummary instance) =>
    <String, dynamic>{
      'aggregated_pnl': instance.aggregatedPnl,
    };

PortfolioBalances _$PortfolioBalancesFromJson(Map<String, dynamic> json) =>
    PortfolioBalances(
      portfolioBalances: (json['portfolio_balances'] as List<dynamic>)
          .map((e) => PortfolioBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PortfolioBalancesToJson(PortfolioBalances instance) =>
    <String, dynamic>{
      'portfolio_balances': instance.portfolioBalances,
    };

PortfolioBalance _$PortfolioBalanceFromJson(Map<String, dynamic> json) =>
    PortfolioBalance(
      portfolioUuid: json['portfolio_uuid'] as String,
      balances: (json['balances'] as List<dynamic>)
          .map((e) => Balance.fromJson(e as Map<String, dynamic>))
          .toList(),
      isMarginLimitReached: json['is_margin_limit_reached'] as bool,
    );

Map<String, dynamic> _$PortfolioBalanceToJson(PortfolioBalance instance) =>
    <String, dynamic>{
      'portfolio_uuid': instance.portfolioUuid,
      'balances': instance.balances,
      'is_margin_limit_reached': instance.isMarginLimitReached,
    };

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      asset: Asset.fromJson(json['asset'] as Map<String, dynamic>),
      quantity: json['quantity'] as String,
      hold: json['hold'] as String,
      transferHold: json['transfer_hold'] as String,
      collateralValue: json['collateral_value'] as String,
      collateralWeight: json['collateral_weight'] as String,
      maxWithdrawAmount: json['max_withdraw_amount'] as String,
      loan: json['loan'] as String,
      loanCollateralRequirementUsd:
          json['loan_collateral_requirement_usd'] as String,
      pledgedQuantity: json['pledged_quantity'] as String,
      maxPortfolioTransferAmount:
          json['max_portfolio_transfer_amount'] as String,
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
      'asset': instance.asset,
      'quantity': instance.quantity,
      'hold': instance.hold,
      'transfer_hold': instance.transferHold,
      'collateral_value': instance.collateralValue,
      'collateral_weight': instance.collateralWeight,
      'max_withdraw_amount': instance.maxWithdrawAmount,
      'loan': instance.loan,
      'loan_collateral_requirement_usd': instance.loanCollateralRequirementUsd,
      'pledged_quantity': instance.pledgedQuantity,
      'max_portfolio_transfer_amount': instance.maxPortfolioTransferAmount,
    };

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      assetId: json['asset_id'] as String,
      assetUuid: json['asset_uuid'] as String,
      assetName: json['asset_name'] as String,
      status: json['status'] as String,
      collateralWeight: json['collateral_weight'] as String,
      accountCollateralLimit: json['account_collateral_limit'] as String,
      ecosystemCollateralLimitBreached:
          json['ecosystem_collateral_limit_breached'] as bool,
      assetIconUrl: json['asset_icon_url'] as String,
      supportedNetworksEnabled: json['supported_networks_enabled'] as bool,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'asset_id': instance.assetId,
      'asset_uuid': instance.assetUuid,
      'asset_name': instance.assetName,
      'status': instance.status,
      'collateral_weight': instance.collateralWeight,
      'account_collateral_limit': instance.accountCollateralLimit,
      'ecosystem_collateral_limit_breached':
          instance.ecosystemCollateralLimitBreached,
      'asset_icon_url': instance.assetIconUrl,
      'supported_networks_enabled': instance.supportedNetworksEnabled,
    };
