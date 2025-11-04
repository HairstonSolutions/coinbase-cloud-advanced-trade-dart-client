class ScheduleFuturesSweep {
  final bool success;

  ScheduleFuturesSweep({required this.success});

  factory ScheduleFuturesSweep.fromCBJson(Map<String, dynamic> json) {
    return ScheduleFuturesSweep(
      success: json['success'],
    );
  }
}
