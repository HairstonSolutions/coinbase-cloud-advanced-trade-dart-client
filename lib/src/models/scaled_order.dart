class ScaledOrder {
  final String? quoteSize;
  final String? baseSize;
  final String limitPrice;
  final bool postOnly;

  ScaledOrder(
      {this.quoteSize,
      this.baseSize,
      required this.limitPrice,
      this.postOnly = false});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quoteSize != null) data['quote_size'] = quoteSize;
    if (baseSize != null) data['base_size'] = baseSize;
    data['limit_price'] = limitPrice;
    data['post_only'] = postOnly;
    return data;
  }
}
