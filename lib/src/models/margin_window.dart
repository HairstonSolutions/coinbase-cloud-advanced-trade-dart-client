class MarginWindow {
  final String marginWindowType;
  final String endTime;

  MarginWindow({required this.marginWindowType, required this.endTime});

  factory MarginWindow.fromCBJson(Map<String, dynamic> json) {
    return MarginWindow(
      marginWindowType: json['margin_window_type'],
      endTime: json['end_time'],
    );
  }
}
