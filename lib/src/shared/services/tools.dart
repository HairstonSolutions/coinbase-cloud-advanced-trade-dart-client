import 'dart:convert';

import 'package:coinbase_cloud_advanced_trade_client/src/shared/models/signature.dart';
import 'package:crypto/crypto.dart';

Signature generateSignature(
    String secret, String httpMethod, String requestPath, String body) {
  var currentTimestamp = DateTime.now().millisecondsSinceEpoch / 1000; // in ms
  String cbAccessTimestamp = currentTimestamp.toString();

  // Create the pre-hash string by concatenating required parts
  String messageToSign = cbAccessTimestamp + httpMethod + requestPath + body;

  // Decode Base64 Encoded Secret into an 8-bit Byte sequence (Binary)
  List<int> binaryKey = secret.codeUnits;

  // Get the Sha256 keyed-hash message authentication code (HMAC)
  Hmac hmac = Hmac(sha256, binaryKey);
  Digest hmacHashedMessageDigest = hmac.convert(messageToSign.codeUnits);

  // Convert HMAC Digest into the final Signature Hash
  String returnSignature = hmacHashedMessageDigest.toString();

  return Signature(returnSignature, cbAccessTimestamp, messageToSign);
}

double? nullableDouble(var jsonObject, String key,
    {bool? notNullable = false}) {
  if (notNullable == true) {
    return (jsonObject[key] == null) ? 0.0 : double.parse(jsonObject[key]);
  }
  if (jsonObject[key] == "") {
    return null;
  }
  return (jsonObject[key] == null) ? null : double.parse(jsonObject[key]);
}

String? convertParamsToString(Map<String, dynamic> queryParameters) {
  late String conversion;
  conversion = "";

  if (queryParameters.isNotEmpty) {
    conversion = "?";
    int count = 0;

    for (var entry in queryParameters.entries) {
      if (count > 0) {
        conversion = "$conversion&";
      }
      conversion = "$conversion${entry.key}=${entry.value}";
      count++;
    }
  }

  return conversion;
}
