import 'package:json_annotation/json_annotation.dart';


part 'spol.g.dart';

@JsonSerializable()
class Spol {
  int? spolId;
  String? naziv;


  Spol({this.spolId, this.naziv});

  factory Spol.fromJson(Map<String, dynamic> json) =>
      _$SpolFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SpolToJson(this);

}