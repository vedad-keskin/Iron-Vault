// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dobavljac.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dobavljac _$DobavljacFromJson(Map<String, dynamic> json) => Dobavljac(
      dobavljacId: (json['dobavljacId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
    );

Map<String, dynamic> _$DobavljacToJson(Dobavljac instance) => <String, dynamic>{
      'dobavljacId': instance.dobavljacId,
      'naziv': instance.naziv,
    };
