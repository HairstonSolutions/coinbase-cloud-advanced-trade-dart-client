import 'package:coinbase_cloud_advanced_trade_client/src/models/perpetuals_portfolio.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/summary.dart';

class PerpetualsPortfolioSummary {
  final List<PerpetualsPortfolio> portfolios;
  final Summary summary;

  PerpetualsPortfolioSummary({required this.portfolios, required this.summary});

  factory PerpetualsPortfolioSummary.fromCBJson(Map<String, dynamic> json) {
    var portfolios = <PerpetualsPortfolio>[];
    for (var portfolio in json['portfolios']) {
      portfolios.add(PerpetualsPortfolio.fromCBJson(portfolio));
    }

    return PerpetualsPortfolioSummary(
      portfolios: portfolios,
      summary: Summary.fromCBJson(json['summary']),
    );
  }
}
