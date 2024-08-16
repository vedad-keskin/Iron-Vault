import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'narudzba.g.dart';

@JsonSerializable()
class Narudzba {
  int? narudzbaId;
  int? korisnikId;
  Korisnik? korisnik;
  DateTime? datumVrijemeNarudzbe;
  bool? status;
  bool? otkazano;

  Narudzba({this.narudzbaId});

  factory Narudzba.fromJson(Map<String, dynamic> json) =>
      _$NarudzbaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NarudzbaToJson(this);
}
