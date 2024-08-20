// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biznis_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BizniReport _$BizniReportFromJson(Map<String, dynamic> json) => BizniReport(


    )
      ..ukupnoKorisnici = (json['ukupnoKorisnici'] as num?)?.toInt()
      ..korisniciUTeretani = (json['korisniciUTeretani'] as num?)?.toInt()
      ..zaradaMjesecaNaClanarinama = (json['zaradaMjesecaNaClanarinama'] as num?)?.toDouble()
      ..zaradaMjesecaNaKupovinama = (json['zaradaMjesecaNaKupovinama'] as num?)?.toDouble()
      ..ukupnaZaradaMjeseca = (json['ukupnaZaradaMjeseca'] as num?)?.toDouble()
      ..najaktivnijiKorisnik = json['najaktivnijiKorisnik'] == null
          ? null
          : Korisnik.fromJson(json['najaktivnijiKorisnik'] as Map<String, dynamic>)
      ..najboljaOcjenaSuplement = json['najboljaOcjenaSuplement'] == null
          ? null
          : Suplement.fromJson(json['najboljaOcjenaSuplement'] as Map<String, dynamic>)
      ..najprodavanijiSuplement = json['najprodavanijiSuplement'] == null
          ? null
          : Suplement.fromJson(json['najprodavanijiSuplement'] as Map<String, dynamic>)
      ..najprodavanijiSuplementCount = (json['najprodavanijiSuplementCount'] as num?)?.toInt()
      ;

Map<String, dynamic> _$BizniReportToJson(BizniReport instance) => <String, dynamic>{
      'ukupnoKorisnici': instance.ukupnoKorisnici,
      'korisniciUTeretani': instance.korisniciUTeretani,
      'zaradaMjesecaNaClanarinama': instance.zaradaMjesecaNaClanarinama,
      'zaradaMjesecaNaKupovinama': instance.zaradaMjesecaNaKupovinama,
      'ukupnaZaradaMjeseca': instance.ukupnaZaradaMjeseca,
      'najprodavanijiSuplementCount': instance.najprodavanijiSuplementCount,
      'najprodavanijiSuplement': instance.najprodavanijiSuplement,
      'najboljaOcjenaSuplement': instance.najboljaOcjenaSuplement,
      'najaktivnijiKorisnik': instance.najaktivnijiKorisnik,
    };
