import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class Account {
  final String? uuid;
  final String? name;
  final String? currency;
  final double? availableBalance;
  final bool? isDefault;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
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

  static Account convertJson(var jsonObject) {
    String? uuid = jsonObject['uuid'];
    String? name = jsonObject['name'];
    String? currency = jsonObject['currency'];
    var ab = jsonObject['available_balance'];
    double? availableBalance = nullableDouble(ab, 'value');
    bool? isDefault = jsonObject['default'];
    bool? active = jsonObject['active'];
    String? createdAt = jsonObject['created_at'];
    String? updatedAt = jsonObject['updated_at'];
    String? deletedAt = jsonObject['deleted_at'];
    String? type = jsonObject['type'];
    bool? ready = jsonObject['ready'];
    var hold = jsonObject['hold'];
    double? holdValue = nullableDouble(hold, 'value');

    return Account(uuid, name, currency, availableBalance, isDefault, active,
        createdAt, updatedAt, deletedAt, type, ready, holdValue);
  }
}

/*
{
  "accounts": [
    {
      "uuid": "8bfc20d7-f7c6-4422-bf07-8243ca4169fe",
      "name": "BTC Wallet",
      "currency": "BTC",
      "available_balance": {
        "value": "1.23",
        "currency": "BTC"
      },
      "default": false,
      "active": true,
      "created_at": "2021-05-31T09:59:59Z",
      "updated_at": "2021-05-31T09:59:59Z",
      "deleted_at": "2021-05-31T09:59:59Z",
      "type": "ACCOUNT_TYPE_UNSPECIFIED",
      "ready": true,
      "hold": {
        "value": "1.23",
        "currency": "BTC"
      }
    }
  ],
  "has_next": true,
  "cursor": "789100",
  "size": 0
}
 */
