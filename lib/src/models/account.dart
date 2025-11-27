import 'package:coinbase_cloud_advanced_trade_client/src/services/tools.dart';

/// Account information.
class Account {
  /// The account's uuid.
  final String? uuid;

  /// The account's name.
  final String? name;

  /// The account's currency.
  final String? currency;

  /// The account's available balance.
  final double? availableBalance;

  /// Whether the account is the default account.
  final bool? isDefault;

  /// Whether the account is active.
  final bool? active;

  /// The account's creation time.
  final DateTime? createdAt;

  /// The account's last update time.
  final DateTime? updatedAt;

  /// The account's deletion time.
  final DateTime? deletedAt;

  /// The account's type.
  final String? type;

  /// Whether the account is ready.
  final bool? ready;

  /// The account's hold value.
  final double? holdValue;

  /// Account constructor
  Account(
      this.uuid,
      this.name,
      this.currency,
      this.availableBalance,
      this.isDefault,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.type,
      this.ready,
      this.holdValue);

  /// Creates an Account from a JSON object.
  Account.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        currency = json['currency'],
        availableBalance = json['availableBalance'],
        isDefault = json['isDefault'],
        active = json['active'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']),
        deletedAt = DateTime.parse(json['deletedAt']),
        type = json['type'],
        ready = json['ready'],
        holdValue = json['holdValue'];

  /// Converts an Account to a JSON object.
  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'currency': currency,
        'availableBalance': availableBalance,
        'isDefault': isDefault,
        'active': active,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
        'type': type,
        'ready': ready,
        'holdValue': holdValue
      };

  /// Creates an Account from a Coinbase JSON object.
  Account.fromCBJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        currency = json['currency'],
        availableBalance =
            AvailableBalance.fromCBJson(json['available_balance']).value,
        isDefault = json['default'],
        active = json['active'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        deletedAt = (json['deleted_at'] != null)
            ? DateTime.parse(json['deleted_at'])
            : null,
        type = json['type'],
        ready = json['ready'],
        holdValue = Hold.fromCBJson(json['hold']).value;

  @override
  String toString() {
    String all = '{'
        'uuid=$uuid, name=$name, currency=$currency, '
        'availableBalance=$availableBalance, isDefault=$isDefault, '
        'active=$active, createdAt=$createdAt, updatedAt=$updatedAt, '
        'deletedAt=$deletedAt, type=$type, ready=$ready, holdValue=$holdValue'
        '}';
    return all;
  }
}

/// The available balance for an account.
class AvailableBalance {
  /// The value of the available balance.
  double? value;

  /// The currency of the available balance.
  String? currency;

  /// AvailableBalance constructor
  AvailableBalance(this.value, this.currency);

  /// Creates an AvailableBalance from a Coinbase JSON object.
  AvailableBalance.fromCBJson(Map<String, dynamic> json)
      : value = nullableDouble(json, 'value'),
        currency = json['currency'];
}

/// The hold value for an account.
class Hold {
  /// The value of the hold.
  double? value;

  /// The currency of the hold.
  String? currency;

  /// Hold constructor
  Hold(this.value, this.currency);

  /// Creates a Hold from a Coinbase JSON object.
  Hold.fromCBJson(Map<String, dynamic> json)
      : value = nullableDouble(json, 'value'),
        currency = json['currency'];
}
