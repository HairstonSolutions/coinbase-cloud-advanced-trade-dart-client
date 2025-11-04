import 'package:coinbase_cloud_advanced_trade_client/src/models/futures_position.dart';

class FuturesPositions {
  final List<FuturesPosition> positions;

  FuturesPositions({required this.positions});

  factory FuturesPositions.fromCBJson(Map<String, dynamic> json) {
    var positions = <FuturesPosition>[];
    for (var position in json['positions']) {
      positions.add(FuturesPosition.fromCBJson(position));
    }

    return FuturesPositions(positions: positions);
  }
}
