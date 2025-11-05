import 'package:coinbase_cloud_advanced_trade_client/src/models/amount.dart';

class Fee {
  final String title;
  final String description;
  final Amount amount;
  final String label;
  final Disclosure? disclosure;
  final WaivedDetails? waivedDetails;

  Fee(
      {required this.title,
      required this.description,
      required this.amount,
      required this.label,
      this.disclosure,
      this.waivedDetails});

  factory Fee.fromCBJson(Map<String, dynamic> json) {
    return Fee(
      title: json['title'],
      description: json['description'],
      amount: Amount.fromJson(json['amount']),
      label: json['label'],
      disclosure: json['disclosure'] != null
          ? Disclosure.fromCBJson(json['disclosure'])
          : null,
      waivedDetails: json['waived_details'] != null
          ? WaivedDetails.fromCBJson(json['waived_details'])
          : null,
    );
  }
}

class Disclosure {
  final String title;
  final String description;
  final Link link;

  Disclosure(
      {required this.title, required this.description, required this.link});

  factory Disclosure.fromCBJson(Map<String, dynamic> json) {
    return Disclosure(
      title: json['title'],
      description: json['description'],
      link: Link.fromCBJson(json['link']),
    );
  }
}

class Link {
  final String text;
  final String url;

  Link({required this.text, required this.url});

  factory Link.fromCBJson(Map<String, dynamic> json) {
    return Link(
      text: json['text'],
      url: json['url'],
    );
  }
}

class WaivedDetails {
  final Amount amount;
  final String source;

  WaivedDetails({required this.amount, required this.source});

  factory WaivedDetails.fromCBJson(Map<String, dynamic> json) {
    return WaivedDetails(
      amount: Amount.fromJson(json['amount']),
      source: json['source'],
    );
  }
}
