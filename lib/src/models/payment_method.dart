/// Represents a payment method on Coinbase.
class PaymentMethod {
  /// Unique identifier for the payment method.
  final String? id;

  /// Type of payment method (e.g., "ACH", "WIRE").
  final String? type;

  /// Name of the payment method.
  final String? name;

  /// Currency of the payment method.
  final String? currency;

  /// Whether the payment method is verified.
  final bool? verified;

  /// Whether the payment method can be used to buy.
  final bool? allowBuy;

  /// Whether the payment method can be used to sell.
  final bool? allowSell;

  /// Whether the payment method can be used for deposits.
  final bool? allowDeposit;

  /// Whether the payment method can be used for withdrawals.
  final bool? allowWithdraw;

  /// When the payment method was created.
  final DateTime? createdAt;

  /// When the payment method was last updated.
  final DateTime? updatedAt;

  /// Creates a new [PaymentMethod].
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

  /// Creates a [PaymentMethod] from a JSON object.
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
}
