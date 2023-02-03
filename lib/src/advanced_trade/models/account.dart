import 'package:coinbase_cloud_advanced_trade_client/src/shared/services/tools.dart';

class Account {
  final String? uuid;
  final String? name;
  final String? currency;
  final double? availableBalance;
  final bool? isDefault;
  final bool? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? type;
  final bool? ready;
  final double? holdValue;

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
  toString() {
    String all = '{'
        'uuid=$uuid, name=$name, currency=$currency, '
        'availableBalance=$availableBalance, isDefault=$isDefault, '
        'active=$active, createdAt=$createdAt, updatedAt=$updatedAt, '
        'deletedAt=$deletedAt, type=$type, ready=$ready, holdValue=$holdValue'
        '}';
    return all;
  }
}

class AvailableBalance {
  double? value;
  String? currency;

  AvailableBalance(this.value, this.currency);

  AvailableBalance.fromCBJson(Map<String, dynamic> json)
      : value = nullableDouble(json, 'value'),
        currency = json['currency'];
}

class Hold {
  double? value;
  String? currency;

  Hold(this.value, this.currency);

  Hold.fromCBJson(Map<String, dynamic> json)
      : value = nullableDouble(json, 'value'),
        currency = json['currency'];
}
