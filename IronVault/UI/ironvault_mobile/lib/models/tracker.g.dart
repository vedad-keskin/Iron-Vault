// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tracker _$TrackerFromJson(Map<String, dynamic> json) => Tracker()
  ..korisnikId = (json['korisnikId'] as num?)?.toInt()
  ..korisnik = json['korisnik'] == null
      ? null
      : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>)
  ..ukupnoKupljeno = (json['ukupnoKupljeno'] as num?)?.toInt()
  ..ukupnoPrisutava = (json['ukupnoPrisutava'] as num?)?.toInt();

Map<String, dynamic> _$TrackerToJson(Tracker instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'ukupnoKupljeno': instance.ukupnoKupljeno,
      'ukupnoPrisutava': instance.ukupnoPrisutava,
    };
