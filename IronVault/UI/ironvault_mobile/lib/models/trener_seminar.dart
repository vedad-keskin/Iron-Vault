import 'package:ironvault_mobile/models/seminar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trener_seminar.g.dart';

@JsonSerializable()
class TrenerSeminar {
  int? trenerSeminarId;
  int? trenerId;
  int? seminarId;
  Seminar? seminar;

  TrenerSeminar({this.trenerSeminarId});

  factory TrenerSeminar.fromJson(Map<String, dynamic> json) =>
      _$TrenerSeminarFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TrenerSeminarToJson(this);
}
