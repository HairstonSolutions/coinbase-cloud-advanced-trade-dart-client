class MarginWindowMeasure {
  final String marginWindowType;
  final String marginLevel;
  final String initialMargin;
  final String maintenanceMargin;
  final String liquidationBuffer;
  final String totalHold;
  final String futuresBuyingPower;

  MarginWindowMeasure(
      {required this.marginWindowType,
      required this.marginLevel,
      required this.initialMargin,
      required this.maintenanceMargin,
      required this.liquidationBuffer,
      required this.totalHold,
      required this.futuresBuyingPower});

  factory MarginWindowMeasure.fromCBJson(Map<String, dynamic> json) {
    return MarginWindowMeasure(
      marginWindowType: json['margin_window_type'],
      marginLevel: json['margin_level'],
      initialMargin: json['initial_margin'],
      maintenanceMargin: json['maintenance_margin'],
      liquidationBuffer: json['liquidation_buffer'],
      totalHold: json['total_hold'],
      futuresBuyingPower: json['futures_buying_power'],
    );
  }
}
