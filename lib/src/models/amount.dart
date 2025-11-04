import 'package:json_annotation/json_annotation.dart';

part 'amount.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Amount {
  final String value;
  final String currency;

  Amount({required this.value, required this.currency});

  factory Amount.fromJson(Map<String, dynamic> json) =>
      _$AmountFromJson(json);

  Map<String, dynamic> toJson() => _$AmountToJson(this);
}
