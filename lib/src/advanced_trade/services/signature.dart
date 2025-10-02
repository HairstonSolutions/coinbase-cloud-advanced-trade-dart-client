import 'dart:math';

import 'package:jose/jose.dart';

/// Generates a JWT for authenticating with the Coinbase API.
///
/// [keyName] - The Coinbase API Key Name (used for 'sub' and 'kid').
/// [privateKeyPem] - The PEM-encoded EC private key string.
/// [uri] - The request URI, formatted as "METHOD host/path".
///
/// Returns a signed JWT string.
Future<String> generateCoinbaseJwt(
  String keyName,
  String privateKeyPem,
  String uri,
) async {
  // Set the token's expiration time to 2 minutes from now
  var expiry = DateTime.now().add(const Duration(minutes: 2));
  var notBefore = DateTime.now();

  // Create the JWT claims
  final claims = JsonWebTokenClaims.fromJson({
    'iss': 'cdp',
    'nbf': notBefore.millisecondsSinceEpoch ~/ 1000,
    'exp': expiry.millisecondsSinceEpoch ~/ 1000,
    'sub': keyName,
    'uri': uri,
  });

  // Create a builder for the JWS
  final builder = JsonWebSignatureBuilder();

  // Set the JWT payload
  builder.jsonContent = claims.toJson();

  // Add the private key for signing
  final key = JsonWebKey.fromPem(privateKeyPem);
  builder.addRecipient(key, algorithm: 'ES256');

  // Set protected headers
  final nonce = Random.secure().nextInt(1 << 32).toString();
  builder.setProtectedHeader('kid', keyName);
  builder.setProtectedHeader('nonce', nonce);
  builder.setProtectedHeader('typ', 'JWT');

  // Build the JWS and sign it
  final jws = builder.build();

  // Serialize to compact format
  final token = jws.toCompactSerialization();

  return token;
}
