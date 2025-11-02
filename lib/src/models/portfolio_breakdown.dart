import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio.dart';

class Money {
  final String value;
  final String currency;

  Money({required this.value, required this.currency});

  factory Money.fromCBJson(Map<String, dynamic> json) {
    return Money(
      value: json['value'],
      currency: json['currency'],
    );
  }

  @override
  String toString() {
    return 'Money{value: $value, currency: $currency}';
  }
}

class Vwap {
  final Money userNativeCurrency;
  final Money rawCurrency;

  Vwap({required this.userNativeCurrency, required this.rawCurrency});

  factory Vwap.fromCBJson(Map<String, dynamic> json) {
    return Vwap(
      userNativeCurrency: Money.fromCBJson(json['userNativeCurrency']),
      rawCurrency: Money.fromCBJson(json['rawCurrency']),
    );
  }

  @override
  String toString() {
    return 'Vwap{userNativeCurrency: $userNativeCurrency, rawCurrency: $rawCurrency}';
  }
}

class CurrencyPair {
  final Money userNativeCurrency;
  final Money rawCurrency;

  CurrencyPair({required this.userNativeCurrency, required this.rawCurrency});

  factory CurrencyPair.fromCBJson(Map<String, dynamic> json) {
    return CurrencyPair(
      userNativeCurrency: Money.fromCBJson(json['userNativeCurrency']),
      rawCurrency: Money.fromCBJson(json['rawCurrency']),
    );
  }

  @override
  String toString() {
    return 'CurrencyPair{userNativeCurrency: $userNativeCurrency, rawCurrency: $rawCurrency}';
  }
}

class SpotPosition {
  final String asset;
  final String accountUuid;
  final num totalBalanceFiat;
  final num totalBalanceCrypto;
  final num availableToTradeFiat;
  final num allocation;
  final Money costBasis;
  final String assetImgUrl;
  final bool isCash;
  final Money averageEntryPrice;
  final String assetUuid;
  final num availableToTradeCrypto;
  final num unrealizedPnl;
  final num availableToTransferFiat;
  final num availableToTransferCrypto;
  final String assetColor;
  final String accountType;
  final num fundingPnl;
  final num availableToSendFiat;
  final num availableToSendCrypto;

  SpotPosition(
      {required this.asset,
      required this.accountUuid,
      required this.totalBalanceFiat,
      required this.totalBalanceCrypto,
      required this.availableToTradeFiat,
      required this.allocation,
      required this.costBasis,
      required this.assetImgUrl,
      required this.isCash,
      required this.averageEntryPrice,
      required this.assetUuid,
      required this.availableToTradeCrypto,
      required this.unrealizedPnl,
      required this.availableToTransferFiat,
      required this.availableToTransferCrypto,
      required this.assetColor,
      required this.accountType,
      required this.fundingPnl,
      required this.availableToSendFiat,
      required this.availableToSendCrypto});

  factory SpotPosition.fromCBJson(Map<String, dynamic> json) {
    return SpotPosition(
      asset: json['asset'],
      accountUuid: json['account_uuid'],
      totalBalanceFiat: json['total_balance_fiat'],
      totalBalanceCrypto: json['total_balance_crypto'],
      availableToTradeFiat: json['available_to_trade_fiat'],
      allocation: json['allocation'],
      costBasis: Money.fromCBJson(json['cost_basis']),
      assetImgUrl: json['asset_img_url'],
      isCash: json['is_cash'],
      averageEntryPrice: Money.fromCBJson(json['average_entry_price']),
      assetUuid: json['asset_uuid'],
      availableToTradeCrypto: json['available_to_trade_crypto'],
      unrealizedPnl: json['unrealized_pnl'],
      availableToTransferFiat: json['available_to_transfer_fiat'],
      availableToTransferCrypto: json['available_to_transfer_crypto'],
      assetColor: json['asset_color'],
      accountType: json['account_type'],
      fundingPnl: json['funding_pnl'],
      availableToSendFiat: json['available_to_send_fiat'],
      availableToSendCrypto: json['available_to_send_crypto'],
    );
  }

  @override
  String toString() {
    return 'SpotPosition{asset: $asset, accountUuid: $accountUuid, totalBalanceFiat: $totalBalanceFiat, totalBalanceCrypto: $totalBalanceCrypto, availableToTradeFiat: $availableToTradeFiat, allocation: $allocation, costBasis: $costBasis, assetImgUrl: $assetImgUrl, isCash: $isCash, averageEntryPrice: $averageEntryPrice, assetUuid: $assetUuid, availableToTradeCrypto: $availableToTradeCrypto, unrealizedPnl: $unrealizedPnl, availableToTransferFiat: $availableToTransferFiat, availableToTransferCrypto: $availableToTransferCrypto, assetColor: $assetColor, accountType: $accountType, fundingPnl: $fundingPnl, availableToSendFiat: $availableToSendFiat, availableToSendCrypto: $availableToSendCrypto}';
  }
}

class PerpPosition {
  final String productId;
  final String productUuid;
  final String symbol;
  final String assetImageUrl;
  final Vwap vwap;
  final String positionSide;
  final String netSize;
  final String buyOrderSize;
  final String sellOrderSize;
  final String imContribution;
  final CurrencyPair unrealizedPnl;
  final CurrencyPair markPrice;
  final CurrencyPair liquidationPrice;
  final String leverage;
  final CurrencyPair imNotional;
  final CurrencyPair mmNotional;
  final CurrencyPair positionNotional;
  final String marginType;
  final String liquidationBuffer;
  final String liquidationPercentage;
  final String assetColor;

  PerpPosition(
      {required this.productId,
      required this.productUuid,
      required this.symbol,
      required this.assetImageUrl,
      required this.vwap,
      required this.positionSide,
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
      required this.marginType,
      required this.liquidationBuffer,
      required this.liquidationPercentage,
      required this.assetColor});

  factory PerpPosition.fromCBJson(Map<String, dynamic> json) {
    return PerpPosition(
      productId: json['product_id'],
      productUuid: json['product_uuid'],
      symbol: json['symbol'],
      assetImageUrl: json['asset_image_url'],
      vwap: Vwap.fromCBJson(json['vwap']),
      positionSide: json['position_side'],
      netSize: json['net_size'],
      buyOrderSize: json['buy_order_size'],
      sellOrderSize: json['sell_order_size'],
      imContribution: json['im_contribution'],
      unrealizedPnl: CurrencyPair.fromCBJson(json['unrealized_pnl']),
      markPrice: CurrencyPair.fromCBJson(json['mark_price']),
      liquidationPrice: CurrencyPair.fromCBJson(json['liquidation_price']),
      leverage: json['leverage'],
      imNotional: CurrencyPair.fromCBJson(json['im_notional']),
      mmNotional: CurrencyPair.fromCBJson(json['mm_notional']),
      positionNotional: CurrencyPair.fromCBJson(json['position_notional']),
      marginType: json['margin_type'],
      liquidationBuffer: json['liquidation_buffer'],
      liquidationPercentage: json['liquidation_percentage'],
      assetColor: json['asset_color'],
    );
  }

  @override
  String toString() {
    return 'PerpPosition{productId: $productId, productUuid: $productUuid, symbol: $symbol, assetImageUrl: $assetImageUrl, vwap: $vwap, positionSide: $positionSide, netSize: $netSize, buyOrderSize: $buyOrderSize, sellOrderSize: $sellOrderSize, imContribution: $imContribution, unrealizedPnl: $unrealizedPnl, markPrice: $markPrice, liquidationPrice: $liquidationPrice, leverage: $leverage, imNotional: $imNotional, mmNotional: $mmNotional, positionNotional: $positionNotional, marginType: $marginType, liquidationBuffer: $liquidationBuffer, liquidationPercentage: $liquidationPercentage, assetColor: $assetColor}';
  }
}

class FuturesPosition {
  final String productId;
  final String contractSize;
  final String side;
  final String amount;
  final String avgEntryPrice;
  final String currentPrice;
  final String unrealizedPnl;
  final String expiry;
  final String underlyingAsset;
  final String assetImgUrl;
  final String productName;
  final String venue;
  final String notionalValue;
  final String assetColor;
  final String lastTradedAt;
  final String rollDate;

  FuturesPosition(
      {required this.productId,
      required this.contractSize,
      required this.side,
      required this.amount,
      required this.avgEntryPrice,
      required this.currentPrice,
      required this.unrealizedPnl,
      required this.expiry,
      required this.underlyingAsset,
      required this.assetImgUrl,
      required this.productName,
      required this.venue,
      required this.notionalValue,
      required this.assetColor,
      required this.lastTradedAt,
      required this.rollDate});

  factory FuturesPosition.fromCBJson(Map<String, dynamic> json) {
    return FuturesPosition(
      productId: json['product_id'],
      contractSize: json['contract_size'],
      side: json['side'],
      amount: json['amount'],
      avgEntryPrice: json['avg_entry_price'],
      currentPrice: json['current_price'],
      unrealizedPnl: json['unrealized_pnl'],
      expiry: json['expiry'],
      underlyingAsset: json['underlying_asset'],
      assetImgUrl: json['asset_img_url'],
      productName: json['product_name'],
      venue: json['venue'],
      notionalValue: json['notional_value'],
      assetColor: json['asset_color'],
      lastTradedAt: json['last_traded_at'],
      rollDate: json['roll_date'],
    );
  }

  @override
  String toString() {
    return 'FuturesPosition{productId: $productId, contractSize: $contractSize, side: $side, amount: $amount, avgEntryPrice: $avgEntryPrice, currentPrice: $currentPrice, unrealizedPnl: $unrealizedPnl, expiry: $expiry, underlyingAsset: $underlyingAsset, assetImgUrl: $assetImgUrl, productName: $productName, venue: $venue, notionalValue: $notionalValue, assetColor: $assetColor, lastTradedAt: $lastTradedAt, rollDate: $rollDate}';
  }
}

class PortfolioBalances {
  final Money totalBalance;
  final Money totalFuturesBalance;
  final Money totalCashEquivalentBalance;
  final Money totalCryptoBalance;
  final Money futuresUnrealizedPnl;
  final Money perpUnrealizedPnl;

  PortfolioBalances(
      {required this.totalBalance,
      required this.totalFuturesBalance,
      required this.totalCashEquivalentBalance,
      required this.totalCryptoBalance,
      required this.futuresUnrealizedPnl,
      required this.perpUnrealizedPnl});

  factory PortfolioBalances.fromCBJson(Map<String, dynamic> json) {
    return PortfolioBalances(
      totalBalance: Money.fromCBJson(json['total_balance']),
      totalFuturesBalance: Money.fromCBJson(json['total_futures_balance']),
      totalCashEquivalentBalance:
          Money.fromCBJson(json['total_cash_equivalent_balance']),
      totalCryptoBalance: Money.fromCBJson(json['total_crypto_balance']),
      futuresUnrealizedPnl: Money.fromCBJson(json['futures_unrealized_pnl']),
      perpUnrealizedPnl: Money.fromCBJson(json['perp_unrealized_pnl']),
    );
  }

  @override
  String toString() {
    return 'PortfolioBalances{totalBalance: $totalBalance, totalFuturesBalance: $totalFuturesBalance, totalCashEquivalentBalance: $totalCashEquivalentBalance, totalCryptoBalance: $totalCryptoBalance, futuresUnrealizedPnl: $futuresUnrealizedPnl, perpUnrealizedPnl: $perpUnrealizedPnl}';
  }
}

class PortfolioBreakdown {
  final Portfolio portfolio;
  final PortfolioBalances portfolioBalances;
  final List<SpotPosition> spotPositions;
  final List<PerpPosition> perpPositions;
  final List<FuturesPosition> futuresPositions;

  PortfolioBreakdown(
      {required this.portfolio,
      required this.portfolioBalances,
      required this.spotPositions,
      required this.perpPositions,
      required this.futuresPositions});

  factory PortfolioBreakdown.fromCBJson(Map<String, dynamic> json) {
    List<SpotPosition> spotPositions = [];
    if (json['spot_positions'] != null) {
      for (var position in json['spot_positions']) {
        spotPositions.add(SpotPosition.fromCBJson(position));
      }
    }

    List<PerpPosition> perpPositions = [];
    if (json['perp_positions'] != null) {
      for (var position in json['perp_positions']) {
        perpPositions.add(PerpPosition.fromCBJson(position));
      }
    }

    List<FuturesPosition> futuresPositions = [];
    if (json['futures_positions'] != null) {
      for (var position in json['futures_positions']) {
        futuresPositions.add(FuturesPosition.fromCBJson(position));
      }
    }

    return PortfolioBreakdown(
      portfolio: Portfolio.fromCBJson(json['portfolio']),
      portfolioBalances:
          PortfolioBalances.fromCBJson(json['portfolio_balances']),
      spotPositions: spotPositions,
      perpPositions: perpPositions,
      futuresPositions: futuresPositions,
    );
  }

  @override
  String toString() {
    return 'PortfolioBreakdown{portfolio: $portfolio, portfolioBalances: $portfolioBalances, spotPositions: $spotPositions, perpPositions: $perpPositions, futuresPositions: $futuresPositions}';
  }
}
