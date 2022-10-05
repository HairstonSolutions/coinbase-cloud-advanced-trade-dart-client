import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../models/signature.dart';

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
