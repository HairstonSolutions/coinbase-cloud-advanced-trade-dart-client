class PaymentMethod {
  final String id;
  final String type;
  final String name;
  final String currency;
  final bool verified;
  final bool allowBuy;
  final bool allowSell;
  final bool allowDeposit;
  final bool allowWithdraw;
  final String createdAt;
  final String updatedAt;

  PaymentMethod(
      {required this.id,
      required this.type,
      required this.name,
      required this.currency,
      required this.verified,
      required this.allowBuy,
      required this.allowSell,
      required this.allowDeposit,
      required this.allowWithdraw,
      required this.createdAt,
      required this.updatedAt});

  factory PaymentMethod.fromCBJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      currency: json['currency'],
      verified: json['verified'],
      allowBuy: json['allow_buy'],
      allowSell: json['allow_sell'],
      allowDeposit: json['allow_deposit'],
      allowWithdraw: json['allow_withdraw'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
