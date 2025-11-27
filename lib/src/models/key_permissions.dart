/// The permissions for an API key.
class KeyPermissions {
  /// Whether the key can view.
  final bool canView;

  /// Whether the key can trade.
  final bool canTrade;

  /// Whether the key can transfer.
  final bool canTransfer;

  /// The UUID of the portfolio.
  final String portfolioUuid;

  /// The type of the portfolio.
  final String portfolioType;

  /// KeyPermissions constructor
  KeyPermissions(
      {required this.canView,
      required this.canTrade,
      required this.canTransfer,
      required this.portfolioUuid,
      required this.portfolioType});

  /// Creates a KeyPermissions from a Coinbase JSON object.
  factory KeyPermissions.fromCBJson(Map<String, dynamic> json) {
    return KeyPermissions(
      canView: json['can_view'],
      canTrade: json['can_trade'],
      canTransfer: json['can_transfer'],
      portfolioUuid: json['portfolio_uuid'],
      portfolioType: json['portfolio_type'],
    );
  }

  @override
  String toString() {
    return 'KeyPermissions{canView: $canView, canTrade: $canTrade, canTransfer: $canTransfer, portfolioUuid: $portfolioUuid, portfolioType: $portfolioType}';
  }
}
