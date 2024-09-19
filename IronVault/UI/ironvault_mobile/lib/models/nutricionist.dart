import 'package:json_annotation/json_annotation.dart';

part 'nutricionist.g.dart';

@JsonSerializable()
class Nutricionist {
  int? nutricionistId;
  String? ime;
  String? prezime;
  String? email;
  String? brojTelefona;
  String? slika;

  Nutricionist({this.nutricionistId});

  factory Nutricionist.fromJson(Map<String, dynamic> json) =>
      _$NutricionistFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NutricionistToJson(this);
}
