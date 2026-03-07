import 'package:ironvault_desktop/models/seminar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nutricionist_seminar.g.dart';

@JsonSerializable()
class NutricionistSeminar {
  int? nutricionistSeminarId;
  int? nutricionistId;
  int? seminarId;
  Seminar? seminar;

  NutricionistSeminar({this.nutricionistSeminarId});

  factory NutricionistSeminar.fromJson(Map<String, dynamic> json) =>
      _$NutricionistSeminarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NutricionistSeminarToJson(this);
}
