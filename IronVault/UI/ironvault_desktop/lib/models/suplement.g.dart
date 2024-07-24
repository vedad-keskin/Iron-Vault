// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suplement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suplement _$SuplementFromJson(Map<String, dynamic> json) => Suplement(
      suplementId: (json['suplementId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
    )
      ..gramaza = (json['gramaza'] as num?)?.toDouble()
      ..opis = json['opis'] as String?
      ..cijena = (json['cijena'] as num?)?.toDouble()
      ..prosjecnaOcjena = (json['prosjecnaOcjena'] as num?)?.toDouble()
      ..dobavljacId = (json['dobavljacId'] as num?)?.toInt()
      ..kategorijaId = (json['kategorijaId'] as num?)?.toInt();

Map<String, dynamic> _$SuplementToJson(Suplement instance) => <String, dynamic>{
      'suplementId': instance.suplementId,
      'naziv': instance.naziv,
      'gramaza': instance.gramaza,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
      'dobavljacId': instance.dobavljacId,
      'kategorijaId': instance.kategorijaId,
    };
