/// Custom exception for Coinbase API errors.
class CoinbaseException implements Exception {
  /// The error message.
  final String message;

  /// The HTTP status code.
  final int statusCode;

  /// The response body.
  final String responseBody;

  /// CoinbaseException constructor
  CoinbaseException(this.message, this.statusCode, this.responseBody);

  @override
  String toString() {
    return 'CoinbaseException: $message (Status: $statusCode, Response: $responseBody)';
  }
}
