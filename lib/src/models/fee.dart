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
}

/*
Example:
{
  "maker_fee_rate": "0.004",
  "taker_fee_rate": "0.006",
  "usd_volume": null
}
 */
