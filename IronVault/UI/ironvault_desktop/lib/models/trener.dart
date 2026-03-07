import 'package:json_annotation/json_annotation.dart';

part 'trener.g.dart';

@JsonSerializable()
class Trener {
  int? trenerId;
  String? ime;
  String? prezime;
  String? email;
  String? brojTelefona;
  String? slika;

  Trener({this.trenerId});

  factory Trener.fromJson(Map<String, dynamic> json) =>
      _$TrenerFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TrenerToJson(this);
}
