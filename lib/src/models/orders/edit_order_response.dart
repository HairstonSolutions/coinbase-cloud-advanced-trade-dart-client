import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_error.dart';

class EditOrderResponse {
  final bool? success;
  final List<EditOrderError>? errors;

  EditOrderResponse({this.success, this.errors});

  factory EditOrderResponse.fromCBJson(Map<String, dynamic> json) {
    return EditOrderResponse(
      success: json['success'],
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => EditOrderError.fromCBJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'EditOrderResponse{success: $success, errors: $errors}';
  }
}
