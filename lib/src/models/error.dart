/// Custom exception for Coinbase API errors.
class CoinbaseException implements Exception {
  final String message;
  final int statusCode;
  final String responseBody;

  CoinbaseException(this.message, this.statusCode, this.responseBody);

  @override
  String toString() {
    return 'CoinbaseException: $message (Status: $statusCode, Response: $responseBody)';
  }
}
