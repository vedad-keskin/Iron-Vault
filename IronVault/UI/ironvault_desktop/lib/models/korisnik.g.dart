// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
    )
      ..ime = json['ime'] as String?
      ..prezime = json['prezime'] as String?
      ..korisnickoIme = json['korisnickoIme'] as String?
      ..email = json['email'] as String?
      ..slika = json['slika'] as String?
      ..brojTelefona = json['brojTelefona'] as String?
      ..visina = (json['visina'] as num?)?.toDouble()
      ..tezina = (json['tezina'] as num?)?.toDouble()
      ..razina = (json['razina'] as num?)?.toInt()
      ..vrijemeUteretani = json['vrijemeUteretani'] == null
          ? null
          : Duration(microseconds: (json['vrijemeUteretani'] as num).toInt())
      ..gradId = (json['gradId'] as num?)?.toInt()
      ..spolId = (json['spolId'] as num?)?.toInt()
      ..teretanaId = (json['teretanaId'] as num?)?.toInt();

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'slika': instance.slika,
      'brojTelefona': instance.brojTelefona,
      'visina': instance.visina,
      'tezina': instance.tezina,
      'razina': instance.razina,
      'vrijemeUteretani': instance.vrijemeUteretani?.inMicroseconds,
      'gradId': instance.gradId,
      'spolId': instance.spolId,
      'teretanaId': instance.teretanaId,
    };
