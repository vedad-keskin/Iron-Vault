import 'dart:ffi';

import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'biznis_report.g.dart';

@JsonSerializable()
class BizniReport {
  int? ukupnoKorisnici;
  int? korisniciUTeretani;
  double? ukupnaZaradaMjeseca;
  double? zaradaMjesecaNaClanarinama;
  double? zaradaMjesecaNaKupovinama;
  Suplement? najprodavanijiSuplement;
  int? najprodavanijiSuplementCount;
  Suplement? najboljaOcjenaSuplement;
  Korisnik? najaktivnijiKorisnik;

  BizniReport();

  factory BizniReport.fromJson(Map<String, dynamic> json) =>
      _$BizniReportFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BizniReportToJson(this);
}
