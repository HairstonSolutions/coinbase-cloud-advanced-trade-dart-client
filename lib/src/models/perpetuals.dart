import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';
import 'package:json_annotation/json_annotation.dart';

part 'perpetuals.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PerpetualsPortfolioSummary {
  final Amount totalAccountValue;
  final Amount totalMargin;
  final Amount availableMargin;
  final Amount initialMargin;
  final Amount maintenanceMargin;
  final Amount totalPnl;
  final Amount portfolioIm;
  final Amount portfolioMm;
  final String portfolioUuid;
  final String collateralCurrency;
  final List<Collateral> collaterals;

  PerpetualsPortfolioSummary({
    required this.totalAccountValue,
    required this.totalMargin,
    required this.availableMargin,
    required this.initialMargin,
    required this.maintenanceMargin,
    required this.totalPnl,
    required this.portfolioIm,
    required this.portfolioMm,
    required this.portfolioUuid,
    required this.collateralCurrency,
    required this.collaterals,
  });

  factory PerpetualsPortfolioSummary.fromJson(Map<String, dynamic> json) =>
      _$PerpetualsPortfolioSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PerpetualsPortfolioSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Collateral {
  final String assetName;
  final Amount amount;
  final String haircut;
  final String collateralValue;

  Collateral({
    required this.assetName,
    required this.amount,
    required this.haircut,
    required this.collateralValue,
  });

  factory Collateral.fromJson(Map<String, dynamic> json) =>
      _$CollateralFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PerpetualsPositions {
  final List<PerpetualsPosition> positions;
  final PerpetualsPositionsSummary summary;

  PerpetualsPositions({required this.positions, required this.summary});

  factory PerpetualsPositions.fromJson(Map<String, dynamic> json) =>
      _$PerpetualsPositionsFromJson(json);

  Map<String, dynamic> toJson() => _$PerpetualsPositionsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PerpetualsPosition {
  final String productId;
  final String productUuid;
  final String portfolioUuid;
  final String symbol;
  final Amount vwap;
  final Amount entryVwap;
  final String positionSide;
  final String marginType;
  final String netSize;
  final String buyOrderSize;
  final String sellOrderSize;
  final String imContribution;
  final Amount unrealizedPnl;
  final Amount markPrice;
  final Amount liquidationPrice;
  final String leverage;
  final Amount imNotional;
  final Amount mmNotional;
  final Amount positionNotional;
  final Amount aggregatedPnl;

  PerpetualsPosition({
    required this.productId,
    required this.productUuid,
    required this.portfolioUuid,
    required this.symbol,
    required this.vwap,
    required this.entryVwap,
    required this.positionSide,
    required this.marginType,
    required this.netSize,
    required this.buyOrderSize,
    required this.sellOrderSize,
    required this.imContribution,
    required this.unrealizedPnl,
    required this.markPrice,
    required this.liquidationPrice,
    required this.leverage,
    required this.imNotional,
    required this.mmNotional,
    required this.positionNotional,
    required this.aggregatedPnl,
  });

  factory PerpetualsPosition.fromJson(Map<String, dynamic> json) =>
      _$PerpetualsPositionFromJson(json);

  Map<String, dynamic> toJson() => _$PerpetualsPositionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PerpetualsPositionsSummary {
  final Amount aggregatedPnl;

  PerpetualsPositionsSummary({required this.aggregatedPnl});

  factory PerpetualsPositionsSummary.fromJson(Map<String, dynamic> json) =>
      _$PerpetualsPositionsSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PerpetualsPositionsSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PortfolioBalances {
  final List<PortfolioBalance> portfolioBalances;

  PortfolioBalances({required this.portfolioBalances});

  factory PortfolioBalances.fromJson(Map<String, dynamic> json) =>
      _$PortfolioBalancesFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioBalancesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PortfolioBalance {
  final String portfolioUuid;
  final List<Balance> balances;
  final bool isMarginLimitReached;

  PortfolioBalance({
    required this.portfolioUuid,
    required this.balances,
    required this.isMarginLimitReached,
  });

  factory PortfolioBalance.fromJson(Map<String, dynamic> json) =>
      _$PortfolioBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioBalanceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Balance {
  final Asset asset;
  final String quantity;
  final String hold;
  final String transferHold;
  final String collateralValue;
  final String collateralWeight;
  final String maxWithdrawAmount;
  final String loan;
  final String loanCollateralRequirementUsd;
  final String pledgedQuantity;
  final String maxPortfolioTransferAmount;

  Balance({
    required this.asset,
    required this.quantity,
    required this.hold,
    required this.transferHold,
    required this.collateralValue,
    required this.collateralWeight,
    required this.maxWithdrawAmount,
    required this.loan,
    required this.loanCollateralRequirementUsd,
    required this.pledgedQuantity,
    required this.maxPortfolioTransferAmount,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => _$BalanceFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Asset {
  final String assetId;
  final String assetUuid;
  final String assetName;
  final String status;
  final String collateralWeight;
  final String accountCollateralLimit;
  final bool ecosystemCollateralLimitBreached;
  final String assetIconUrl;
  final bool supportedNetworksEnabled;

  Asset({
    required this.assetId,
    required this.assetUuid,
    required this.assetName,
    required this.status,
    required this.collateralWeight,
    required this.accountCollateralLimit,
    required this.ecosystemCollateralLimitBreached,
    required this.assetIconUrl,
    required this.supportedNetworksEnabled,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}
