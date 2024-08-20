// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_clanarina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikClanarina _$KorisnikClanarinaFromJson(Map<String, dynamic> json) =>
    KorisnikClanarina(
      korisnikClanarinaId: (json['korisnikClanarinaId'] as num?)?.toInt(),
    )
      ..korisnikId = (json['korisnikId'] as num?)?.toInt()
      ..clanarinaId = (json['clanarinaId'] as num?)?.toInt()
      ..clanarina = json['clanarina'] == null
          ? null
          : Clanarina.fromJson(json['clanarina'] as Map<String, dynamic>)
      ..datumUplate = json['datumUplate'] == null
          ? null
          : DateTime.parse(json['datumUplate'] as String)
      ..datumIsteka = json['datumIsteka'] == null
          ? null
          : DateTime.parse(json['datumIsteka'] as String);

Map<String, dynamic> _$KorisnikClanarinaToJson(KorisnikClanarina instance) =>
    <String, dynamic>{
      'korisnikClanarinaId': instance.korisnikClanarinaId,
      'korisnikId': instance.korisnikId,
      'clanarinaId': instance.clanarinaId,
      'clanarina': instance.clanarina,
      'datumUplate': instance.datumUplate?.toIso8601String(),
      'datumIsteka': instance.datumIsteka?.toIso8601String(),
    };
