// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

double? _stringToDouble(dynamic value) =>
    value is String ? double.tryParse(value) : value as double?;

String? _doubleToString(double? value) => value?.toString();

Duration? _stringToDuration(dynamic value) {
  if (value is String) {
    // Assuming the string represents the duration in seconds
    final intSeconds = int.tryParse(value);
    if (intSeconds != null) {
      return Duration(seconds: intSeconds);
    }
  } else if (value is int) {
    // Assuming the value is an integer representing seconds
    return Duration(seconds: value);
  }
  return null;
}

String? _durationToString(Duration? value) => value?.inSeconds.toString();




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
      // napravio sam custom za duration, TODO viditi da li radi
      ..vrijemeUteretani = json['vrijemeUteretani'] == null
          ? null
          : _stringToDuration(json['vrijemeUteretani'])
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
