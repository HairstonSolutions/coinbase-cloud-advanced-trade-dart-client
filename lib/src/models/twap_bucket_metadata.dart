class TwapBucketMetadata {
  final String bucketDuration;
  final String bucketSize;
  final String numberBuckets;
  final String startTime;
  final String endTime;

  TwapBucketMetadata(
      {required this.bucketDuration,
      required this.bucketSize,
      required this.numberBuckets,
      required this.startTime,
      required this.endTime});

  factory TwapBucketMetadata.fromCBJson(Map<String, dynamic> json) {
    return TwapBucketMetadata(
      bucketDuration: json['bucket_duration'],
      bucketSize: json['bucket_size'],
      numberBuckets: json['number_buckets'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
