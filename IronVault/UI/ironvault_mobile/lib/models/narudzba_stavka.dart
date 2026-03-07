import 'package:ironvault_mobile/models/suplement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'narudzba_stavka.g.dart';

@JsonSerializable()
class NarudzbaStavka {
  int? narudzbaStavkaId;
  int? narudzbaId;
  int? suplementId;
  Suplement? suplement;
  int? kolicina;

  NarudzbaStavka({this.narudzbaStavkaId});

  factory NarudzbaStavka.fromJson(Map<String, dynamic> json) =>
      _$NarudzbaStavkaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NarudzbaStavkaToJson(this);
}
