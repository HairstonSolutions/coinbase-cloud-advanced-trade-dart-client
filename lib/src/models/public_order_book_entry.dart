class PublicOrderBookEntry {
  final String price;
  final String size;

  PublicOrderBookEntry(this.price, this.size);

  factory PublicOrderBookEntry.fromCBJson(Map<String, dynamic> json) {
    return PublicOrderBookEntry(
      json['price'],
      json['size'],
    );
  }
}
