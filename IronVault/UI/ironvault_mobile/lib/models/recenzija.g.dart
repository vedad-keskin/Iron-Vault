// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzija _$RecenzijaFromJson(Map<String, dynamic> json) => Recenzija(
      recenzijaId: (json['recenzijaId'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
      ..suplementId = (json['suplementId'] as num?)?.toInt()
      ..suplement = json['suplement'] == null
          ? null
          : Suplement.fromJson(json['suplement'] as Map<String, dynamic>)
      ..ocjena = (json['ocjena'] as num?)?.toInt()
      ..opis = json['opis'] as String?;

Map<String, dynamic> _$RecenzijaToJson(Recenzija instance) => <String, dynamic>{
      'recenzijaId': instance.recenzijaId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'suplementId': instance.suplementId,
      'suplement': instance.suplement,
      'ocjena': instance.ocjena,
      'opis': instance.opis,
    };
