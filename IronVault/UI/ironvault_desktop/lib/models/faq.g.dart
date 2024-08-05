// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faq _$FaqFromJson(Map<String, dynamic> json) => Faq(
      faqid: (json['faqid'] as num?)?.toInt(),
    )
      ..pitanje = json['pitanje'] as String?
      ..odgovor = json['odgovor'] as String?;

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
      'faqId': instance.faqid,
      'pitanje': instance.pitanje,
      'odgovor': instance.odgovor,
    };
