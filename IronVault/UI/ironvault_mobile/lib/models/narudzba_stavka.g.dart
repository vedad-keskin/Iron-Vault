// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba_stavka.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NarudzbaStavka _$NarudzbaStavkaFromJson(Map<String, dynamic> json) =>
    NarudzbaStavka(
      narudzbaStavkaId: (json['narudzbaStavkaId'] as num?)?.toInt(),
    )
      ..narudzbaId = (json['narudzbaId'] as num?)?.toInt()
      ..suplementId = (json['suplementId'] as num?)?.toInt()
      ..suplement = json['suplement'] == null
          ? null
          : Suplement.fromJson(json['suplement'] as Map<String, dynamic>)
      ..kolicina = (json['kolicina'] as num?)?.toInt();

Map<String, dynamic> _$NarudzbaStavkaToJson(NarudzbaStavka instance) =>
    <String, dynamic>{
      'narudzbaStavkaId': instance.narudzbaStavkaId,
      'narudzbaId': instance.narudzbaId,
      'suplementId': instance.suplementId,
      'suplement': instance.suplement,
      'kolicina': instance.kolicina,
    };
