import 'dart:convert';

import 'package:coinbase_pro_sdk/src/models/signature.dart';
import 'package:crypto/crypto.dart';

/// Generates a signature for authenticating with the Coinbase Pro API.
///
/// [secret] - The user's API secret.
/// [httpMethod] - The HTTP method of the request.
/// [requestPath] - The path of the request.
/// [body] - The body of the request.
///
/// Returns a [Signature] object.
Signature signature(
    String secret, String httpMethod, String requestPath, String body) {
  var currentTimestamp = DateTime.now().millisecondsSinceEpoch / 1000; // in ms
  String cbAccessTimestamp = currentTimestamp.toString();

  // Create the pre-hash string by concatenating required parts
  String messageToSign = cbAccessTimestamp + httpMethod + requestPath + body;

  // Decode Base64 Encoded Secret into an 8-bit Byte sequence (Binary)
  List<int> binaryKey = base64Decode(secret);

  // Get the Sha256 keyed-hash message authentication code (HMAC)
  Hmac hmac = Hmac(sha256, binaryKey);
  Digest hmacHashedMessageDigest = hmac.convert(messageToSign.codeUnits);

  // Convert HMAC Digest into the final Base64 Encoded Signature Hash
  String returnSignature = base64Encode(hmacHashedMessageDigest.bytes);

  return Signature(returnSignature, cbAccessTimestamp, messageToSign);
}
