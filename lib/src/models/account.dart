import 'package:coinbase_cloud_exchange_dart_client/src/services/tools.dart';

class Account {
  final String? id;
  final String? currency;
  final double? balance;
  final double? hold;
  final double? available;
  final String? profileId;
  final bool? tradingEnabled;

  Account(this.id, this.currency, this.balance, this.hold, this.available,
      this.profileId, this.tradingEnabled);

  @override
  String toString() {
    String all = '{'
        'id=$id, currency=$currency, balance=$balance, hold=$hold,'
        'available=$available, profileId=$profileId,'
        'tradingEnabled=$tradingEnabled'
        '}';
    return all;
  }

  static Account convertJson(var jsonObject) {
    String? id = jsonObject['id'];
    String? currency = jsonObject['currency'];
    double? balance = nullableDouble(jsonObject, 'balance');
    double? hold = nullableDouble(jsonObject, 'hold');
    double? available = nullableDouble(jsonObject, 'available');
    String? profileId = jsonObject['profile_id'];
    bool? tradingEnabled = jsonObject['trading_enabled'];

    return Account(
        id, currency, balance, hold, available, profileId, tradingEnabled);
  }
}

/*
{
  "id": "7fd0abc0-e5ad-4cbb-8d54-f2b3f43364da",
  "currency": "USD",
  "balance": "0.0000000000000000",
  "hold": "0.0000000000000000",
  "available": "0",
  "profile_id": "8058d771-2d88-4f0f-ab6e-299c153d4308",
  "trading_enabled": true
}
 */
