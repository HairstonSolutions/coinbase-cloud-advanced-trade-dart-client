/// A representation of a price level.
class PriceLevel {
  /// The price of the level.
  final String price;

  /// The size of the level.
  final String size;

  /// PriceLevel constructor
  PriceLevel({required this.price, required this.size});

  /// Creates a PriceLevel from a JSON object.
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

/// A representation of a product book.
class ProductBook {
  /// The product ID.
  final String productId;

  /// The bids.
  final List<PriceLevel> bids;

  /// The asks.
  final List<PriceLevel> asks;

  /// The time of the book.
  final DateTime? time;

  /// ProductBook constructor
  ProductBook(
      {required this.productId,
      required this.bids,
      required this.asks,
      this.time});

  /// Creates a ProductBook from a JSON object.
  factory ProductBook.fromJson(Map<String, dynamic> json) {
    return ProductBook.fromMap(json['pricebook']);
  }

  /// Creates a ProductBook from a map.
  factory ProductBook.fromMap(Map<String, dynamic> map) {
    var bidsList = map['bids'] as List;
    var asksList = map['asks'] as List;

    List<PriceLevel> bids =
        bidsList.map((i) => PriceLevel.fromJson(i)).toList();
    List<PriceLevel> asks =
        asksList.map((i) => PriceLevel.fromJson(i)).toList();

    return ProductBook(
      productId: map['product_id'],
      bids: bids,
      asks: asks,
      time:
          map['time'] != null ? DateTime.tryParse(map['time'] as String) : null,
    );
  }

  @override
  String toString() {
    return '{productId: $productId, bids: $bids, asks: $asks, time: $time}';
  }
}
