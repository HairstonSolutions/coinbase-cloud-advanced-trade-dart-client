import 'package:coinbase_cloud_advanced_trade_client/src/models/edit_order_error.dart';

class EditOrderResult {
  final bool success;
  final List<EditOrderError> errors;

  EditOrderResult({required this.success, required this.errors});

  factory EditOrderResult.fromCBJson(Map<String, dynamic> json) {
    var errors = <EditOrderError>[];
    for (var error in json['errors']) {
      errors.add(EditOrderError.fromCBJson(error));
    }

    return EditOrderResult(
      success: json['success'],
      errors: errors,
    );
  }
}
