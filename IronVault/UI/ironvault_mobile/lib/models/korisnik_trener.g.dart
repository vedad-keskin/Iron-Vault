// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_trener.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikTrener _$KorisnikTrenerFromJson(Map<String, dynamic> json) =>
    KorisnikTrener(
      korisnikTrenerId: (json['korisnikTrenerId'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
      ..trenerId = (json['trenerId'] as num?)?.toInt()
      ..trener = json['trener'] == null
          ? null
          : Trener.fromJson(json['trener'] as Map<String, dynamic>)
      ..datumTermina = json['datumTermina'] == null
          ? null
          : DateTime.parse(json['datumTermina'] as String)
      ..zakazanoSati = (json['zakazanoSati'] as num?)?.toInt();

Map<String, dynamic> _$KorisnikTrenerToJson(KorisnikTrener instance) =>
    <String, dynamic>{
      'korisnikTrenerId': instance.korisnikTrenerId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'trenerId': instance.trenerId,
      'trener': instance.trener,
      'datumTermina': instance.datumTermina?.toIso8601String(),
      'zakazanoSati': instance.zakazanoSati,
    };
