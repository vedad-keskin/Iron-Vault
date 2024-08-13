// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spol _$SpolFromJson(Map<String, dynamic> json) => Spol(
      spolId: (json['spolId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
    );

Map<String, dynamic> _$SpolToJson(Spol instance) => <String, dynamic>{
      'spolId': instance.spolId,
      'naziv': instance.naziv,
    };
