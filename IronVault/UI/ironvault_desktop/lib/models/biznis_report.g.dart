// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biznis_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BizniReport _$BizniReportFromJson(Map<String, dynamic> json) => BizniReport()
  ..ukupnoKorisnici = (json['ukupnoKorisnici'] as num?)?.toInt()
  ..korisniciUTeretani = (json['korisniciUTeretani'] as num?)?.toInt()
  ..ukupnaZaradaMjeseca = (json['ukupnaZaradaMjeseca'] as num?)?.toDouble()
  ..zaradaMjesecaNaClanarinama =
      (json['zaradaMjesecaNaClanarinama'] as num?)?.toDouble()
  ..zaradaMjesecaNaKupovinama =
      (json['zaradaMjesecaNaKupovinama'] as num?)?.toDouble()
  ..najprodavanijiSuplement = json['najprodavanijiSuplement'] == null
      ? null
      : Suplement.fromJson(
          json['najprodavanijiSuplement'] as Map<String, dynamic>)
  ..najprodavanijiSuplementCount =
      (json['najprodavanijiSuplementCount'] as num?)?.toInt()
  ..najboljaOcjenaSuplement = json['najboljaOcjenaSuplement'] == null
      ? null
      : Suplement.fromJson(
          json['najboljaOcjenaSuplement'] as Map<String, dynamic>)
  ..najaktivnijiKorisnik = json['najaktivnijiKorisnik'] == null
      ? null
      : Korisnik.fromJson(json['najaktivnijiKorisnik'] as Map<String, dynamic>);

Map<String, dynamic> _$BizniReportToJson(BizniReport instance) =>
    <String, dynamic>{
      'ukupnoKorisnici': instance.ukupnoKorisnici,
      'korisniciUTeretani': instance.korisniciUTeretani,
      'ukupnaZaradaMjeseca': instance.ukupnaZaradaMjeseca,
      'zaradaMjesecaNaClanarinama': instance.zaradaMjesecaNaClanarinama,
      'zaradaMjesecaNaKupovinama': instance.zaradaMjesecaNaKupovinama,
      'najprodavanijiSuplement': instance.najprodavanijiSuplement,
      'najprodavanijiSuplementCount': instance.najprodavanijiSuplementCount,
      'najboljaOcjenaSuplement': instance.najboljaOcjenaSuplement,
      'najaktivnijiKorisnik': instance.najaktivnijiKorisnik,
    };
