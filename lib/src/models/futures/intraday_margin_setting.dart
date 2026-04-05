/// Intraday margin setting options.
enum IntradayMarginSetting {
  /// Unspecified intraday margin setting.
  unspecified('INTRADAY_MARGIN_SETTING_UNSPECIFIED'),

  /// Standard intraday margin setting.
  standard('INTRADAY_MARGIN_SETTING_STANDARD'),

  /// Intraday margin setting.
  intraday('INTRADAY_MARGIN_SETTING_INTRADAY');

  const IntradayMarginSetting(this.value);

  /// The String value of the enum.
  final String value;

  /// Converts an IntradayMarginSetting to a Coinbase string.
  String toCB() {
    return value;
  }

  /// Creates an IntradayMarginSetting from a Coinbase string.
  static IntradayMarginSetting fromCB(String cb) {
    return IntradayMarginSetting.values.firstWhere((e) => e.value == cb,
        orElse: () => IntradayMarginSetting.unspecified);
  }
}

/// Represents the intraday margin setting response.
class IntradayMarginSettingResponse {
  /// The current intraday margin setting.
  final IntradayMarginSetting setting;

  /// Constructor for [IntradayMarginSettingResponse].
  IntradayMarginSettingResponse({
    required this.setting,
  });

  /// Factory constructor to create an [IntradayMarginSettingResponse] from a JSON map.
  factory IntradayMarginSettingResponse.fromCBJson(Map<String, dynamic> json) {
    return IntradayMarginSettingResponse(
      setting: IntradayMarginSetting.fromCB(
          json['setting'] ?? 'INTRADAY_MARGIN_SETTING_UNSPECIFIED'),
    );
  }
}
