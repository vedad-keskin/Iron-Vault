import 'package:json_annotation/json_annotation.dart';

part 'seminar.g.dart';

@JsonSerializable()
class Seminar {
  int? seminarId;
  String? tema;
  String? predavac;
  DateTime? datum;

  Seminar({this.seminarId, this.tema});

  factory Seminar.fromJson(Map<String, dynamic> json) =>
      _$SeminarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SeminarToJson(this);
}
