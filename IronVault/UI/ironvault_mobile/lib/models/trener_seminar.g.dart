// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trener_seminar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrenerSeminar _$TrenerSeminarFromJson(Map<String, dynamic> json) =>
    TrenerSeminar(
      trenerSeminarId: (json['trenerSeminarId'] as num?)?.toInt(),
    )
      ..trenerId = (json['trenerId'] as num?)?.toInt()
      ..seminarId = (json['seminarId'] as num?)?.toInt()
      ..seminar = json['seminar'] == null
          ? null
          : Seminar.fromJson(json['seminar'] as Map<String, dynamic>);

Map<String, dynamic> _$TrenerSeminarToJson(TrenerSeminar instance) =>
    <String, dynamic>{
      'trenerSeminarId': instance.trenerSeminarId,
      'trenerId': instance.trenerId,
      'seminarId': instance.seminarId,
      'seminar': instance.seminar,
    };
