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
      ..vrijemeUteretani = json['vrijemeUteretani'] as String?
      ..razina = (json['razina'] as num?)?.toInt()
      ..gradId = (json['gradId'] as num?)?.toInt()
      ..grad = json['grad'] == null
          ? null
          : Grad.fromJson(json['grad'] as Map<String, dynamic>)
      ..spolId = (json['spolId'] as num?)?.toInt()
      ..spol = json['spol'] == null
          ? null
          : Spol.fromJson(json['spol'] as Map<String, dynamic>)
      ..lozinka = json['lozinka'] as String?
      ..lozinkaPotvrda = json['lozinkaPotvrda'] as String?;

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
      'vrijemeUteretani': instance.vrijemeUteretani,
      'razina': instance.razina,
      'gradId': instance.gradId,
      'grad': instance.grad,
      'spolId': instance.spolId,
      'spol': instance.spol,
      'lozinka': instance.lozinka,
      'lozinkaPotvrda': instance.lozinkaPotvrda,
    };
