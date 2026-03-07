// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutricionist_seminar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutricionistSeminar _$NutricionistSeminarFromJson(Map<String, dynamic> json) =>
    NutricionistSeminar(
      nutricionistSeminarId: (json['nutricionistSeminarId'] as num?)?.toInt(),
    )
      ..nutricionistId = (json['nutricionistId'] as num?)?.toInt()
      ..seminarId = (json['seminarId'] as num?)?.toInt()
      ..seminar = json['seminar'] == null
          ? null
          : Seminar.fromJson(json['seminar'] as Map<String, dynamic>);

Map<String, dynamic> _$NutricionistSeminarToJson(
        NutricionistSeminar instance) =>
    <String, dynamic>{
      'nutricionistSeminarId': instance.nutricionistSeminarId,
      'nutricionistId': instance.nutricionistId,
      'seminarId': instance.seminarId,
      'seminar': instance.seminar,
    };
