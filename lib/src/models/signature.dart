/// A representation of a signature.
class Signature {
  /// The signature.
  final String signature;

  /// The timestamp.
  final String timestamp;

  /// The message to sign.
  final String messageToSign;

  /// Signature constructor
  Signature(this.signature, this.timestamp, this.messageToSign);

  @override
  String toString() {
    String all = '{signature=$signature, timestamp=$timestamp, '
        'messageToSign=$messageToSign}';
    return all;
  }
}
