// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_nutricionist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikNutricionist _$KorisnikNutricionistFromJson(
        Map<String, dynamic> json) =>
    KorisnikNutricionist(
      korisnikNutricionistId: (json['korisnikNutricionistId'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
      ..nutricionistId = (json['nutricionistId'] as num?)?.toInt()
      ..nutricionist = json['nutricionist'] == null
          ? null
          : Nutricionist.fromJson(json['nutricionist'] as Map<String, dynamic>)
      ..datumTermina = json['datumTermina'] == null
          ? null
          : DateTime.parse(json['datumTermina'] as String)
      ..zakazanoSati = (json['zakazanoSati'] as num?)?.toInt();

Map<String, dynamic> _$KorisnikNutricionistToJson(
        KorisnikNutricionist instance) =>
    <String, dynamic>{
      'korisnikNutricionistId': instance.korisnikNutricionistId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'nutricionistId': instance.nutricionistId,
      'nutricionist': instance.nutricionist,
      'datumTermina': instance.datumTermina?.toIso8601String(),
      'zakazanoSati': instance.zakazanoSati,
    };
