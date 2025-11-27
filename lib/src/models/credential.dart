/// A credential for accessing the Coinbase API.
class Credential {
  /// The name of the API key.
  final String apiKeyName;

  /// The private key in PEM format.
  final String privateKeyPEM;

  /// Credential constructor
  Credential({
    required this.apiKeyName,
    required String privateKeyPEM,
  }) : privateKeyPEM = _formatPEM(privateKeyPEM);

  static String _formatPEM(String pem) {
    // Replace the literal text '\\n' with the newline character '\n'.
    return pem.replaceAll(r'\n', '\n');
  }

  @override
  String toString() {
    return 'Credential{apiKeyName: $apiKeyName}';
  }
}
