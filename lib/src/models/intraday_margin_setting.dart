class IntradayMarginSetting {
  final String setting;

  IntradayMarginSetting({required this.setting});

  factory IntradayMarginSetting.fromCBJson(Map<String, dynamic> json) {
    return IntradayMarginSetting(
      setting: json['setting'],
    );
  }
}
