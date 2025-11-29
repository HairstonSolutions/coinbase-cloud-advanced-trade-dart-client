class EditOrderError {
  final String? editFailureReason;
  final String? previewFailureReason;

  EditOrderError({this.editFailureReason, this.previewFailureReason});

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
