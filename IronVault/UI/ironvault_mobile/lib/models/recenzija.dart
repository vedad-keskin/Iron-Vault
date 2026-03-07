import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recenzija.g.dart';

@JsonSerializable()
class Recenzija {
  int? recenzijaId;
  int? korisnikId;
  Korisnik? korisnik;
  int? suplementId;
  Suplement? suplement;
  int? ocjena;
  String? opis;

  Recenzija({this.recenzijaId});

  factory Recenzija.fromJson(Map<String, dynamic> json) =>
      _$RecenzijaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RecenzijaToJson(this);
}
