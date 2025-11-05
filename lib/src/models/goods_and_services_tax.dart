class GoodsAndServicesTax {
  final String rate;
  final String type;

  GoodsAndServicesTax({required this.rate, required this.type});

  factory GoodsAndServicesTax.fromCBJson(Map<String, dynamic> json) {
    return GoodsAndServicesTax(
      rate: json['rate'],
      type: json['type'],
    );
  }

  @override
  String toString() {
    return 'GoodsAndServicesTax{rate: $rate, type: $type}';
  }
}
