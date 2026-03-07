import 'package:ironvault_mobile/models/grad.dart';
import 'package:ironvault_mobile/models/spol.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? korisnickoIme;
  String? email;
  String? slika;
  String? brojTelefona;
  double? visina;
  double? tezina;
  String? vrijemeUteretani;
  int? razina;
  int? gradId;
  Grad? grad;
  int? spolId;
  Spol? spol;
  String? lozinka;
  String? lozinkaPotvrda;
  int? satiUteretani;

  Korisnik({this.korisnikId});

  // / Connect the generated [_$PersonFromJson] function to the `fromJson`
  // / factory.
  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
