// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seminar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seminar _$SeminarFromJson(Map<String, dynamic> json) => Seminar(
      seminarId: (json['seminarId'] as num?)?.toInt(),
      tema: json['tema'] as String?,
    )
      ..predavac = json['predavac'] as String?
      ..datum = json['datum'] == null
          ? null
          : DateTime.parse(json['datum'] as String);

Map<String, dynamic> _$SeminarToJson(Seminar instance) => <String, dynamic>{
      'seminarId': instance.seminarId,
      'tema': instance.tema,
      'predavac': instance.predavac,
      'datum': instance.datum?.toIso8601String(),
    };
