class PnlConfiguration {
  final String pnlCurrency;

  PnlConfiguration({required this.pnlCurrency});

  factory PnlConfiguration.fromCBJson(Map<String, dynamic> json) {
    return PnlConfiguration(
      pnlCurrency: json['pnl_currency'],
    );
  }
}
