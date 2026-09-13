/// Custom exception for Coinbase API errors.
class CoinbaseException implements Exception {
  /// The error message.
  final String message;

  /// The HTTP status code.
  final int statusCode;

  /// The response body.
  final String responseBody;

  /// The retry after duration (typically for 429 errors).
  final Duration? retryAfter;

  /// CoinbaseException constructor
  CoinbaseException(this.message, this.statusCode, this.responseBody,
      {this.retryAfter});

  @override
  String toString() {
    String base =
        'CoinbaseException: $message (Status: $statusCode, Response: $responseBody)';
    if (retryAfter != null) {
      base += ', Retry-After: $retryAfter';
    }
    return base;
  }
}

/// Custom exception for Timeout errors.
class CoinbaseTimeoutException extends CoinbaseException {
  /// CoinbaseTimeoutException constructor
  CoinbaseTimeoutException(String message)
      : super(message, 408, 'Request timed out');
}
