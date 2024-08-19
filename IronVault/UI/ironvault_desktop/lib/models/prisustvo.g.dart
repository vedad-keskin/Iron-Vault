// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prisustvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prisustvo _$PrisustvoFromJson(Map<String, dynamic> json) => Prisustvo(
      prisustvoId: (json['prisustvoId'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..korisnik = json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
      ..datumVrijemeUlaska = json['datumVrijemeUlaska'] == null
          ? null
          : DateTime.parse(json['datumVrijemeUlaska'] as String)
      ..datumVrijemeIzlaska = json['datumVrijemeIzlaska'] == null
          ? null
          : DateTime.parse(json['datumVrijemeIzlaska'] as String);

Map<String, dynamic> _$PrisustvoToJson(Prisustvo instance) => <String, dynamic>{
      'prisustvoId': instance.prisustvoId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'datumVrijemeUlaska': instance.datumVrijemeUlaska?.toIso8601String(),
      'datumVrijemeIzlaska': instance.datumVrijemeIzlaska?.toIso8601String(),
    };
