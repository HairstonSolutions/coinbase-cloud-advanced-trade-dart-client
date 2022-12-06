import 'package:coinbase_cloud_advanced_trade_client/src/shared/models/signature.dart';
import 'package:crypto/crypto.dart';

Signature signature(String secret, String httpMethod, String requestPath,
    {String body = ''}) {
  var currentTimestamp = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
  String cbAccessTimestamp = currentTimestamp.toString();

  // Create the pre-hash string by concatenating required parts
  String messageToSign = cbAccessTimestamp + httpMethod + requestPath + body;

  // Binary Encode Secret into an 8-bit Byte sequence (Binary)
  List<int> binaryKey = secret.codeUnits;

  // Get the Sha256 keyed-hash message authentication code (HMAC)
  Hmac hmac = Hmac(sha256, binaryKey);
  Digest hmacHashedMessageDigest = hmac.convert(messageToSign.codeUnits);

  // Convert HMAC Digest into the final Signature Hash
  String returnSignature = hmacHashedMessageDigest.toString();

  return Signature(returnSignature, cbAccessTimestamp, messageToSign);
}
