import 'package:coinbase_cloud_advanced_trade_client/src/models/margin_window.dart';

class CurrentMarginWindow {
  final MarginWindow marginWindow;
  final bool isIntradayMarginKillswitchEnabled;
  final bool isIntradayMarginEnrollmentKillswitchEnabled;

  CurrentMarginWindow(
      {required this.marginWindow,
      required this.isIntradayMarginKillswitchEnabled,
      required this.isIntradayMarginEnrollmentKillswitchEnabled});

  factory CurrentMarginWindow.fromCBJson(Map<String, dynamic> json) {
    return CurrentMarginWindow(
      marginWindow: MarginWindow.fromCBJson(json['margin_window']),
      isIntradayMarginKillswitchEnabled:
          json['is_intraday_margin_killswitch_enabled'],
      isIntradayMarginEnrollmentKillswitchEnabled:
          json['is_intraday_margin_enrollment_killswitch_enabled'],
    );
  }
}
