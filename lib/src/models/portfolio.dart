/// A portfolio.
class Portfolio {
  /// The UUID of the portfolio.
  final String uuid;

  /// The name of the portfolio.
  final String name;

  /// The type of the portfolio.
  final String type;

  /// Whether the portfolio is deleted.
  final bool deleted;

  /// Portfolio constructor
  Portfolio({
    required this.uuid,
    required this.name,
    required this.type,
    required this.deleted,
  });

  /// Creates a Portfolio from a Coinbase JSON object.
  factory Portfolio.fromCBJson(Map<String, dynamic> json) {
    return Portfolio(
      uuid: json['uuid'],
      name: json['name'],
      type: json['type'],
      deleted: json['deleted'],
    );
  }

  @override
  String toString() {
    String all = '{'
        'uuid=$uuid, name=$name, type=$type, '
        'deleted=$deleted'
        '}';
    return all;
  }
}
