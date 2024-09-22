import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/models/nutricionist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik_nutricionist.g.dart';

@JsonSerializable()
class KorisnikNutricionist {
  int? korisnikNutricionistId;
  int? korisnikId;
  Korisnik? korisnik;
  int? nutricionistId;
  Nutricionist? nutricionist;
  DateTime? datumTermina;
  int? zakazanoSati;

  KorisnikNutricionist({this.korisnikNutricionistId});

  factory KorisnikNutricionist.fromJson(Map<String, dynamic> json) =>
      _$KorisnikNutricionistFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikNutricionistToJson(this);
}
