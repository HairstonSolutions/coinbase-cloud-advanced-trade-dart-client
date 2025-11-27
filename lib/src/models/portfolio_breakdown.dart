import 'package:coinbase_cloud_advanced_trade_client/src/models/portfolio.dart';

/// A representation of money.
class Money {
  /// The value of the money.
  final String value;

  /// The currency of the money.
  final String currency;

  /// Money constructor
  Money({required this.value, required this.currency});

  /// Creates a Money from a Coinbase JSON object.
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

/// A representation of the volume-weighted average price.
class Vwap {
  /// The VWAP in the user's native currency.
  final Money userNativeCurrency;

  /// The VWAP in the raw currency.
  final Money rawCurrency;

  /// Vwap constructor
  Vwap({required this.userNativeCurrency, required this.rawCurrency});

  /// Creates a Vwap from a Coinbase JSON object.
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

/// A representation of a currency pair.
class CurrencyPair {
  /// The currency pair in the user's native currency.
  final Money userNativeCurrency;

  /// The currency pair in the raw currency.
  final Money rawCurrency;

  /// CurrencyPair constructor
  CurrencyPair({required this.userNativeCurrency, required this.rawCurrency});

  /// Creates a CurrencyPair from a Coinbase JSON object.
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

/// A representation of a spot position.
class SpotPosition {
  /// The asset.
  final String asset;

  /// The account UUID.
  final String accountUuid;

  /// The total balance in fiat.
  final num totalBalanceFiat;

  /// The total balance in crypto.
  final num totalBalanceCrypto;

  /// The available to trade balance in fiat.
  final num availableToTradeFiat;

  /// The allocation.
  final num allocation;

  /// The cost basis.
  final Money costBasis;

  /// The asset image URL.
  final String assetImgUrl;

  /// Whether the asset is cash.
  final bool isCash;

  /// The average entry price.
  final Money averageEntryPrice;

  /// The asset UUID.
  final String assetUuid;

  /// The available to trade balance in crypto.
  final num availableToTradeCrypto;

  /// The unrealized PNL.
  final num unrealizedPnl;

  /// The available to transfer balance in fiat.
  final num availableToTransferFiat;

  /// The available to transfer balance in crypto.
  final num availableToTransferCrypto;

  /// The asset color.
  final String assetColor;

  /// The account type.
  final String accountType;

  /// The funding PNL.
  final num fundingPnl;

  /// The available to send balance in fiat.
  final num availableToSendFiat;

  /// The available to send balance in crypto.
  final num availableToSendCrypto;

  /// SpotPosition constructor
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

  /// Creates a SpotPosition from a Coinbase JSON object.
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

/// A representation of a perpetual position.
class PerpPosition {
  /// The product ID.
  final String productId;

  /// The product UUID.
  final String productUuid;

  /// The symbol.
  final String symbol;

  /// The asset image URL.
  final String assetImageUrl;

  /// The VWAP.
  final Vwap vwap;

  /// The position side.
  final String positionSide;

  /// The net size.
  final String netSize;

  /// The buy order size.
  final String buyOrderSize;

  /// The sell order size.
  final String sellOrderSize;

  /// The IM contribution.
  final String imContribution;

  /// The unrealized PNL.
  final CurrencyPair unrealizedPnl;

  /// The mark price.
  final CurrencyPair markPrice;

  /// The liquidation price.
  final CurrencyPair liquidationPrice;

  /// The leverage.
  final String leverage;

  /// The IM notional.
  final CurrencyPair imNotional;

  /// The MM notional.
  final CurrencyPair mmNotional;

  /// The position notional.
  final CurrencyPair positionNotional;

  /// The margin type.
  final String marginType;

  /// The liquidation buffer.
  final String liquidationBuffer;

  /// The liquidation percentage.
  final String liquidationPercentage;

  /// The asset color.
  final String assetColor;

  /// PerpPosition constructor
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

  /// Creates a PerpPosition from a Coinbase JSON object.
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

/// A representation of a futures position.
class FuturesPosition {
  /// The product ID.
  final String productId;

  /// The contract size.
  final String contractSize;

  /// The side.
  final String side;

  /// The amount.
  final String amount;

  /// The average entry price.
  final String avgEntryPrice;

  /// The current price.
  final String currentPrice;

  /// The unrealized PNL.
  final String unrealizedPnl;

  /// The expiry.
  final String expiry;

  /// The underlying asset.
  final String underlyingAsset;

  /// The asset image URL.
  final String assetImgUrl;

  /// The product name.
  final String productName;

  /// The venue.
  final String venue;

  /// The notional value.
  final String notionalValue;

  /// The asset color.
  final String assetColor;

  /// The last traded at time.
  final String lastTradedAt;

  /// The roll date.
  final String rollDate;

  /// FuturesPosition constructor
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

  /// Creates a FuturesPosition from a Coinbase JSON object.
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

/// A representation of portfolio balances.
class PortfolioBalances {
  /// The total balance.
  final Money totalBalance;

  /// The total futures balance.
  final Money totalFuturesBalance;

  /// The total cash equivalent balance.
  final Money totalCashEquivalentBalance;

  /// The total crypto balance.
  final Money totalCryptoBalance;

  /// The futures unrealized PNL.
  final Money futuresUnrealizedPnl;

  /// The perpetuals unrealized PNL.
  final Money perpUnrealizedPnl;

  /// PortfolioBalances constructor
  PortfolioBalances(
      {required this.totalBalance,
      required this.totalFuturesBalance,
      required this.totalCashEquivalentBalance,
      required this.totalCryptoBalance,
      required this.futuresUnrealizedPnl,
      required this.perpUnrealizedPnl});

  /// Creates a PortfolioBalances from a Coinbase JSON object.
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

/// A representation of a portfolio breakdown.
class PortfolioBreakdown {
  /// The portfolio.
  final Portfolio portfolio;

  /// The portfolio balances.
  final PortfolioBalances portfolioBalances;

  /// The spot positions.
  final List<SpotPosition> spotPositions;

  /// The perpetual positions.
  final List<PerpPosition> perpPositions;

  /// The futures positions.
  final List<FuturesPosition> futuresPositions;

  /// PortfolioBreakdown constructor
  PortfolioBreakdown(
      {required this.portfolio,
      required this.portfolioBalances,
      required this.spotPositions,
      required this.perpPositions,
      required this.futuresPositions});

  /// Creates a PortfolioBreakdown from a Coinbase JSON object.
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
