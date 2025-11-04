class ComplianceLimitData {
  final Limit totalLimit;
  final Limit remainingLimits;

  ComplianceLimitData({required this.totalLimit, required this.remainingLimits});

  factory ComplianceLimitData.fromCBJson(Map<String, dynamic> json) {
    return ComplianceLimitData(
      totalLimit: Limit.fromCBJson(json['total_limit']),
      remainingLimits: Limit.fromCBJson(json['remaining_limits']),
    );
  }
}

class Limit {
  final String value;
  final String currency;

  Limit({required this.value, required this.currency});

  factory Limit.fromCBJson(Map<String, dynamic> json) {
    return Limit(
      value: json['value'],
      currency: json['currency'],
    );
  }
}
