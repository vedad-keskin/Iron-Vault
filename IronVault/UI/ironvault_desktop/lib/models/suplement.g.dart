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
      ..slika = json['slika'] as String?
      ..cijena = (json['cijena'] as num?)?.toDouble()
      ..prosjecnaOcjena = (json['prosjecnaOcjena'] as num?)?.toDouble()
      ..dobavljacId = (json['dobavljacId'] as num?)?.toInt()
      ..dobavljac = json['dobavljac'] == null
          ? null
          : Dobavljac.fromJson(json['dobavljac'] as Map<String, dynamic>)
      ..kategorijaId = (json['kategorijaId'] as num?)?.toInt()
      ..kategorija = json['kategorija'] == null
          ? null
          : Kategorija.fromJson(json['kategorija'] as Map<String, dynamic>);

Map<String, dynamic> _$SuplementToJson(Suplement instance) => <String, dynamic>{
      'suplementId': instance.suplementId,
      'naziv': instance.naziv,
      'gramaza': instance.gramaza,
      'opis': instance.opis,
      'slika': instance.slika,
      'cijena': instance.cijena,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
      'dobavljacId': instance.dobavljacId,
      'dobavljac': instance.dobavljac,
      'kategorijaId': instance.kategorijaId,
      'kategorija': instance.kategorija,
    };
