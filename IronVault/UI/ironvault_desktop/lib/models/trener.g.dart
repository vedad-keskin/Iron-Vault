// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trener.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trener _$TrenerFromJson(Map<String, dynamic> json) => Trener(
      trenerId: (json['trenerId'] as num?)?.toInt(),
    )
      ..ime = json['ime'] as String?
      ..prezime = json['prezime'] as String?
      ..email = json['email'] as String?
      ..brojTelefona = json['brojTelefona'] as String?
      ..slika = json['slika'] as String?;

Map<String, dynamic> _$TrenerToJson(Trener instance) => <String, dynamic>{
      'trenerId': instance.trenerId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'brojTelefona': instance.brojTelefona,
      'slika': instance.slika,
    };
