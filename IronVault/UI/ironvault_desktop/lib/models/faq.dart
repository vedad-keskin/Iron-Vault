import 'package:json_annotation/json_annotation.dart';


part 'faq.g.dart';

@JsonSerializable()
class Faq {
  int? faqid;
  String? pitanje;
  String? odgovor;


  Faq({this.faqid});

  factory Faq.fromJson(Map<String, dynamic> json) =>
      _$FaqFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FaqToJson(this);

}