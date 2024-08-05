import 'package:json_annotation/json_annotation.dart';


part 'grad.g.dart';

@JsonSerializable()
class Grad {
  int? gradId;
  String? naziv;


  Grad({this.gradId, this.naziv});

  factory Grad.fromJson(Map<String, dynamic> json) =>
      _$GradFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GradToJson(this);

}