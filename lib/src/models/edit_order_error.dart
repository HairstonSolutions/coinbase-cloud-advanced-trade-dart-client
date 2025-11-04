class EditOrderError {
  final String editFailureReason;
  final String previewFailureReason;

  EditOrderError(
      {required this.editFailureReason, required this.previewFailureReason});

  factory EditOrderError.fromCBJson(Map<String, dynamic> json) {
    return EditOrderError(
      editFailureReason: json['edit_failure_reason'],
      previewFailureReason: json['preview_failure_reason'],
    );
  }
}
