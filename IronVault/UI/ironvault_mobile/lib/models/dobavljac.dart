import 'package:json_annotation/json_annotation.dart';


part 'dobavljac.g.dart';

@JsonSerializable()
class Dobavljac {
  int? dobavljacId;
  String? naziv;


  Dobavljac({this.dobavljacId, this.naziv});

  factory Dobavljac.fromJson(Map<String, dynamic> json) =>
      _$DobavljacFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DobavljacToJson(this);

}