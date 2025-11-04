class ServerTime {
  final String iso;
  final String epochSeconds;
  final String epochMillis;

  ServerTime(this.iso, this.epochSeconds, this.epochMillis);

  factory ServerTime.fromCBJson(Map<String, dynamic> json) {
    return ServerTime(
      json['iso'],
      json['epochSeconds'],
      json['epoch'],
    );
  }
}
