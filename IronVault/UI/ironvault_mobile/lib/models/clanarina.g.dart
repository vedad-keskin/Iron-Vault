// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clanarina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clanarina _$ClanarinaFromJson(Map<String, dynamic> json) => Clanarina(
      clanarinaId: (json['clanarinaId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
    )
      ..cijena = (json['cijena'] as num?)?.toDouble()
      ..opis = json['opis'] as String?;

Map<String, dynamic> _$ClanarinaToJson(Clanarina instance) => <String, dynamic>{
      'clanarinaId': instance.clanarinaId,
      'naziv': instance.naziv,
      'cijena': instance.cijena,
      'opis': instance.opis,
    };
