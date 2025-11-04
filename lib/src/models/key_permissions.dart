class KeyPermissions {
  final bool canView;
  final bool canTrade;
  final bool canTransfer;
  final String portfolioUuid;
  final String portfolioType;

  KeyPermissions(
      {required this.canView,
      required this.canTrade,
      required this.canTransfer,
      required this.portfolioUuid,
      required this.portfolioType});

  factory KeyPermissions.fromCBJson(Map<String, dynamic> json) {
    return KeyPermissions(
      canView: json['can_view'],
      canTrade: json['can_trade'],
      canTransfer: json['can_transfer'],
      portfolioUuid: json['portfolio_uuid'],
      portfolioType: json['portfolio_type'],
    );
  }
}
