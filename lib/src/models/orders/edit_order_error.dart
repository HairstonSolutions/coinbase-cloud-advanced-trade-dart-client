/// Error details for edit order requests.
class EditOrderError {
  /// The reason for edit failure.
  final String? editFailureReason;

  /// The reason for preview failure.
  final String? previewFailureReason;

  /// Creates a new [EditOrderError] instance.
  EditOrderError({this.editFailureReason, this.previewFailureReason});

  /// Creates a new [EditOrderError] instance from a JSON map.
  factory EditOrderError.fromCBJson(Map<String, dynamic> json) {
    return EditOrderError(
      editFailureReason: json['edit_failure_reason'],
      previewFailureReason: json['preview_failure_reason'],
    );
  }

  @override
  String toString() {
    return 'EditOrderError{editFailureReason: $editFailureReason, previewFailureReason: $previewFailureReason}';
  }
}
