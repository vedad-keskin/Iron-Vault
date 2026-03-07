// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzba _$NarudzbaFromJson(Map<String, dynamic> json) => Narudzba(
      narudzbaId: (json['narudzbaId'] as num?)?.toInt(),
    )
      ..sifra = json['sifra'] as String?
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
      ..datumVrijemeNarudzbe = json['datumVrijemeNarudzbe'] == null
          ? null
          : DateTime.parse(json['datumVrijemeNarudzbe'] as String)
      ..status = json['status'] as bool?
      ..otkazano = json['otkazano'] as bool?;

Map<String, dynamic> _$NarudzbaToJson(Narudzba instance) => <String, dynamic>{
      'narudzbaId': instance.narudzbaId,
      'sifra': instance.sifra,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumVrijemeNarudzbe': instance.datumVrijemeNarudzbe?.toIso8601String(),
      'status': instance.status,
      'otkazano': instance.otkazano,
    };
