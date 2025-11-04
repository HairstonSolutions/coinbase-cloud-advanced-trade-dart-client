import 'package:coinbase_cloud_advanced_trade_client/src/models/close_position_error_response.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/close_position_success_response.dart';
import 'package:coinbase_cloud_advanced_trade_client/src/models/order_configuration.dart';

class ClosePositionResult {
  final bool success;
  final ClosePositionSuccessResponse? successResponse;
  final ClosePositionErrorResponse? errorResponse;
  final OrderConfiguration? orderConfiguration;

  ClosePositionResult(
      {required this.success,
      this.successResponse,
      this.errorResponse,
      this.orderConfiguration});

  factory ClosePositionResult.fromCBJson(Map<String, dynamic> json) {
    return ClosePositionResult(
      success: json['success'],
      successResponse: json['success_response'] != null
          ? ClosePositionSuccessResponse.fromCBJson(json['success_response'])
          : null,
      errorResponse: json['error_response'] != null
          ? ClosePositionErrorResponse.fromCBJson(json['error_response'])
          : null,
      orderConfiguration: json['order_configuration'] != null
          ? OrderConfiguration.fromCBJson(json['order_configuration'])
          : null,
    );
  }
}
