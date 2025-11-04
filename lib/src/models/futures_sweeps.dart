import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_sweep.dart';

class FuturesSweeps {
  final List<FuturesSweep> sweeps;

  FuturesSweeps({required this.sweeps});

  factory FuturesSweeps.fromCBJson(Map<String, dynamic> json) {
    var sweeps = <FuturesSweep>[];
    for (var sweep in json['sweeps']) {
      sweeps.add(FuturesSweep.fromCBJson(sweep));
    }

    return FuturesSweeps(sweeps: sweeps);
  }
}
