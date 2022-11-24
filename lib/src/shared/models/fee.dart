import 'package:coinbase_cloud_exchange_dart_client/src/shared/services/tools.dart';

class Fee {
  final double? makerFeeRate;
  final double? takerFeeRate;
  final double? usdVolume;

  Fee(this.makerFeeRate, this.takerFeeRate, this.usdVolume);

  @override
  String toString() {
    String all = '{makerFeeRate=$makerFeeRate, takerFeeRate=$takerFeeRate, '
        'usdVolume=$usdVolume}';
    return all;
  }

  static Fee convertJson(var jsonObject) {
    double? makerFeeRate = double.parse(jsonObject['maker_fee_rate']);
    double? takerFeeRate = double.parse(jsonObject['taker_fee_rate']);

    double? usdVolume =
        nullableDouble(jsonObject, 'usd_volume', notNullable: true);

    return Fee(makerFeeRate, takerFeeRate, usdVolume);
  }
}

/*
Example:
{
  "maker_fee_rate": "0.004",
  "taker_fee_rate": "0.006",
  "usd_volume": null
}
 */
