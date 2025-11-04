class CancelPendingFuturesSweep {
  final bool success;

  CancelPendingFuturesSweep({required this.success});

  factory CancelPendingFuturesSweep.fromCBJson(Map<String, dynamic> json) {
    return CancelPendingFuturesSweep(
      success: json['success'],
    );
  }
}
