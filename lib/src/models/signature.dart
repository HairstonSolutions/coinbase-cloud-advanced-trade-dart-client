class Signature {
  final String signature;
  final String timestamp;
  final String messageToSign;

  Signature(this.signature, this.timestamp, this.messageToSign);

  @override
  String toString() {
    String all = '{signature=$signature, timestamp=$timestamp, '
        'messageToSign=$messageToSign}';
    return all;
  }
}
