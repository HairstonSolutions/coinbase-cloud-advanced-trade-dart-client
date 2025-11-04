class CommissionDetailTotal {
  final String totalCommission;
  final String gstCommission;
  final String withholdingCommission;
  final String clientCommission;
  final String venueCommission;
  final String regulatoryCommission;
  final String clearingCommission;

  CommissionDetailTotal(
      {required this.totalCommission,
      required this.gstCommission,
      required this.withholdingCommission,
      required this.clientCommission,
      required this.venueCommission,
      required this.regulatoryCommission,
      required this.clearingCommission});

  factory CommissionDetailTotal.fromCBJson(Map<String, dynamic> json) {
    return CommissionDetailTotal(
      totalCommission: json['total_commission'],
      gstCommission: json['gst_commission'],
      withholdingCommission: json['withholding_commission'],
      clientCommission: json['client_commission'],
      venueCommission: json['venue_commission'],
      regulatoryCommission: json['regulatory_commission'],
      clearingCommission: json['clearing_commission'],
    );
  }
}
