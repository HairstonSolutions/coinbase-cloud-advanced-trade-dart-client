class Portfolio {
  final String uuid;
  final String name;
  final String type;
  final DateTime createdAt;
  final bool deleted;

  Portfolio({
    required this.uuid,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.deleted,
  });

  factory Portfolio.fromCBJson(Map<String, dynamic> json) {
    return Portfolio(
      uuid: json['uuid'],
      name: json['name'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      deleted: json['deleted'],
    );
  }
}
