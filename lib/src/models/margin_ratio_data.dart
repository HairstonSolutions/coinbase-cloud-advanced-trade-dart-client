class MarginRatioData {
  final String currentMarginRatio;
  final String projectedMarginRatio;

  MarginRatioData(
      {required this.currentMarginRatio, required this.projectedMarginRatio});

  factory MarginRatioData.fromCBJson(Map<String, dynamic> json) {
    return MarginRatioData(
      currentMarginRatio: json['current_margin_ratio'],
      projectedMarginRatio: json['projected_margin_ratio'],
    );
  }
}
