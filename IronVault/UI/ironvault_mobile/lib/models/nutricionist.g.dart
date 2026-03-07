// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutricionist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutricionist _$NutricionistFromJson(Map<String, dynamic> json) => Nutricionist(
      nutricionistId: (json['nutricionistId'] as num?)?.toInt(),
    )
      ..ime = json['ime'] as String?
      ..prezime = json['prezime'] as String?
      ..email = json['email'] as String?
      ..brojTelefona = json['brojTelefona'] as String?
      ..slika = json['slika'] as String?;

Map<String, dynamic> _$NutricionistToJson(Nutricionist instance) =>
    <String, dynamic>{
      'nutricionistId': instance.nutricionistId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'brojTelefona': instance.brojTelefona,
      'slika': instance.slika,
    };
