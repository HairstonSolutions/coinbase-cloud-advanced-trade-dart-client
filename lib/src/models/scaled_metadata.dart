class ScaledMetadata {
  final List<ScaledOrderDistribution> scaledOrderDistribution;

  ScaledMetadata({required this.scaledOrderDistribution});

  factory ScaledMetadata.fromCBJson(Map<String, dynamic> json) {
    var scaledOrderDistribution = <ScaledOrderDistribution>[];
    for (var distribution in json['scaled_order_distribution']) {
      scaledOrderDistribution
          .add(ScaledOrderDistribution.fromCBJson(distribution));
    }

    return ScaledMetadata(scaledOrderDistribution: scaledOrderDistribution);
  }
}

class ScaledOrderDistribution {
  final String size;
  final String price;
  final List<String> errs;
  final List<String> warning;

  ScaledOrderDistribution(
      {required this.size,
      required this.price,
      required this.errs,
      required this.warning});

  factory ScaledOrderDistribution.fromCBJson(Map<String, dynamic> json) {
    return ScaledOrderDistribution(
      size: json['size'],
      price: json['price'],
      errs: List<String>.from(json['errs']),
      warning: List<String>.from(json['warning']),
    );
  }
}
