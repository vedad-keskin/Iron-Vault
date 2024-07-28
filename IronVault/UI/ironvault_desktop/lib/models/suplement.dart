import 'package:ironvault_desktop/models/dobavljac.dart';
import 'package:ironvault_desktop/models/kategorija.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suplement.g.dart';

@JsonSerializable()
class Suplement {
  int? suplementId;
  String? naziv;
  double? gramaza;
  String? opis;
  String? slika;
  double? cijena;
  double? prosjecnaOcjena;
  int? dobavljacId;
  Dobavljac? dobavljac;
  int? kategorijaId;
  Kategorija? kategorija;

  Suplement({this.suplementId, this.naziv});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Suplement.fromJson(Map<String, dynamic> json) =>
      _$SuplementFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SuplementToJson(this);
}
