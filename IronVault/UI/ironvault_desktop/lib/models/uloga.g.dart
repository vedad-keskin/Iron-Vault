// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uloga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uloga _$UlogaFromJson(Map<String, dynamic> json) => Uloga(
      ulogaId: (json['ulogaId'] as num?)?.toInt(),
    )
      ..naziv = json['naziv'] as String?
      ..opis = json['opis'] as String?;

Map<String, dynamic> _$UlogaToJson(Uloga instance) => <String, dynamic>{
      'ulogaId': instance.ulogaId,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
