/// Represents a payment method.
class PaymentMethod {
  /// The unique identifier of the payment method.
  final String? id;

  /// The type of payment method.
  final String? type;

  /// The name associated with the payment method.
  final String? name;

  /// The currency of the payment method.
  final String? currency;

  /// Whether the payment method is verified.
  final bool? verified;

  /// Whether buying is allowed with this payment method.
  final bool? allowBuy;

  /// Whether selling is allowed with this payment method.
  final bool? allowSell;

  /// Whether depositing is allowed with this payment method.
  final bool? allowDeposit;

  /// Whether withdrawing is allowed with this payment method.
  final bool? allowWithdraw;

  /// When the payment method was created.
  final DateTime? createdAt;

  /// When the payment method was last updated.
  final DateTime? updatedAt;

  /// PaymentMethod constructor.
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

  /// Creates a [PaymentMethod] from a Coinbase JSON object.
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
