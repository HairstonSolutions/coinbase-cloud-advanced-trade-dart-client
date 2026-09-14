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

/// Custom exception for network transport failures.
///
/// Thrown when the request never produced an HTTP response: the connection was
/// refused, reset or dropped, DNS lookup failed, or the TLS handshake failed.
/// It wraps the underlying `package:http` or `dart:io` error so callers can
/// treat "the exchange was unreachable" as a Coinbase error rather than having
/// to catch transport types from inside this package.
///
/// Its [statusCode] is `0`, because no response was ever received.
class CoinbaseTransportException extends CoinbaseException {
  /// The HTTP method of the request that failed, e.g. `GET`.
  final String method;

  /// The path of the request that failed, e.g. `/api/v3/brokerage/accounts`.
  final String path;

  /// The underlying transport error, typically an `http.ClientException`,
  /// `SocketException`, `HandshakeException` or `TlsException`.
  final Object cause;

  /// CoinbaseTransportException constructor
  CoinbaseTransportException(this.method, this.path, this.cause)
      : super('Network error on $method $path: $cause', 0, 'No response');

  @override
  String toString() =>
      'CoinbaseTransportException: $message (Method: $method, Path: $path, '
      'Cause: $cause)';
}
