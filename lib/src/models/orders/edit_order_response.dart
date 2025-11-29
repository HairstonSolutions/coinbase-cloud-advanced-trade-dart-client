import 'package:coinbase_cloud_advanced_trade_client/src/models/orders/edit_order_error.dart';

/// Response from edit order request.
class EditOrderResponse {
  /// Whether the request was successful.
  final bool? success;

  /// List of errors if any.
  final List<EditOrderError>? errors;

  /// Creates a new [EditOrderResponse] instance.
  EditOrderResponse({this.success, this.errors});

  /// Creates a new [EditOrderResponse] instance from a JSON map.
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
