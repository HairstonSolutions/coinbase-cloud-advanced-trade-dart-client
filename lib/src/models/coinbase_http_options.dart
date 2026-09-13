import 'package:http/http.dart' as http;

/// Options for configuring the HTTP client behaviors when interacting with
/// the Coinbase Advanced Trade API.
class CoinbaseHttpOptions {
  /// Custom base URL to use for the API requests. This overrides the default
  /// API hosts (api.coinbase.com / api-sandbox.coinbase.com).
  final Uri? baseUrl;

  /// The duration to wait before timing out an HTTP request.
  final Duration? timeout;

  /// A custom [http.Client] to use for the requests. If provided, this client
  /// will be reused across requests.
  final http.Client? client;

  /// Creates a [CoinbaseHttpOptions] instance.
  const CoinbaseHttpOptions({
    this.baseUrl,
    this.timeout,
    this.client,
  });

  @override
  String toString() {
    return 'CoinbaseHttpOptions(baseUrl: $baseUrl, timeout: $timeout, client: $client)';
  }
}
