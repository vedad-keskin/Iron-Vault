// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_uloga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikUloga _$KorisnikUlogaFromJson(Map<String, dynamic> json) =>
    KorisnikUloga(
      korisnikUlogaId: (json['korisnikUlogaId'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..ulogaId = (json['ulogaId'] as num?)?.toInt()
      ..uloga = json['uloga'] == null
          ? null
          : Uloga.fromJson(json['uloga'] as Map<String, dynamic>)
      ..datumIzmjene = json['datumIzmjene'] == null
          ? null
          : DateTime.parse(json['datumIzmjene'] as String);

Map<String, dynamic> _$KorisnikUlogaToJson(KorisnikUloga instance) =>
    <String, dynamic>{
      'korisnikUlogaId': instance.korisnikUlogaId,
      'korisnikId': instance.korisnikId,
      'ulogaId': instance.ulogaId,
      'uloga': instance.uloga,
      'datumIzmjene': instance.datumIzmjene?.toIso8601String(),
    };
