class Credential {
  final String apiKeyName;
  final String privateKeyPEM;

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
