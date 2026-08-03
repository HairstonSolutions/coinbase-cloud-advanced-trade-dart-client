class PaymentMethod {
  final String? id;
  final String? type;
  final String? name;
  final String? currency;
  final bool? verified;
  final bool? allowBuy;
  final bool? allowSell;
  final bool? allowDeposit;
  final bool? allowWithdraw;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentMethod({
    this.id,
    this.type,
    this.name,
    this.currency,
    this.verified,
    this.allowBuy,
    this.allowSell,
    this.allowDeposit,
    this.allowWithdraw,
    this.createdAt,
    this.updatedAt,
  });

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
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  @override
  String toString() {
    return 'PaymentMethod{id: $id, type: $type, name: $name, currency: $currency, verified: $verified, allowBuy: $allowBuy, allowSell: $allowSell, allowDeposit: $allowDeposit, allowWithdraw: $allowWithdraw, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
