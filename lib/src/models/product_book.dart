class PriceLevel {
  final String price;
  final String size;

  PriceLevel({required this.price, required this.size});

  factory PriceLevel.fromJson(Map<String, dynamic> json) {
    return PriceLevel(
      price: json['price'],
      size: json['size'],
    );
  }

  @override
  String toString() {
    return '{price: $price, size: $size}';
  }
}

class ProductBook {
  final String productId;
  final List<PriceLevel> bids;
  final List<PriceLevel> asks;
  final DateTime? time;

  ProductBook(
      {required this.productId,
      required this.bids,
      required this.asks,
      this.time});

  factory ProductBook.fromJson(Map<String, dynamic> json) {
    var pricebook = json['pricebook'];
    var bidsList = pricebook['bids'] as List;
    var asksList = pricebook['asks'] as List;

    List<PriceLevel> bids =
        bidsList.map((i) => PriceLevel.fromJson(i)).toList();
    List<PriceLevel> asks =
        asksList.map((i) => PriceLevel.fromJson(i)).toList();

    return ProductBook(
      productId: pricebook['product_id'],
      bids: bids,
      asks: asks,
      time: pricebook['time'] != null
          ? DateTime.parse(pricebook['time'])
          : null,
    );
  }

  @override
  String toString() {
    return '{productId: $productId, bids: $bids, asks: $asks, time: $time}';
  }
}
