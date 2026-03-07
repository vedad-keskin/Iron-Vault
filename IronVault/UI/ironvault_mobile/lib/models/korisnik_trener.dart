import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/models/trener.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik_trener.g.dart';

@JsonSerializable()
class KorisnikTrener {
  int? korisnikTrenerId;
  int? korisnikId;
  Korisnik? korisnik;
  int? trenerId;
  Trener? trener;
  DateTime? datumTermina;
  int? zakazanoSati;

  KorisnikTrener({this.korisnikTrenerId});

  factory KorisnikTrener.fromJson(Map<String, dynamic> json) =>
      _$KorisnikTrenerFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikTrenerToJson(this);
}
