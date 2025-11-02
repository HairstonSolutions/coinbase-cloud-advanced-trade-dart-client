class Portfolio {
  final String uuid;
  final String name;
  final String type;
  final bool deleted;

  Portfolio({
    required this.uuid,
    required this.name,
    required this.type,
    required this.deleted,
  });

  factory Portfolio.fromCBJson(Map<String, dynamic> json) {
    return Portfolio(
      uuid: json['uuid'],
      name: json['name'],
      type: json['type'],
      deleted: json['deleted'],
    );
  }

  @override
  toString() {
    String all = '{'
        'uuid=$uuid, name=$name, type=$type, '
        'deleted=$deleted'
        '}';
    return all;
  }
}
