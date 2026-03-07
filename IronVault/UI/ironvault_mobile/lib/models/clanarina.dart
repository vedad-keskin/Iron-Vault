import 'package:json_annotation/json_annotation.dart';

part 'clanarina.g.dart';

@JsonSerializable()
class Clanarina {
  int? clanarinaId;
  String? naziv;
  double? cijena;
  String? opis;

  Clanarina({this.clanarinaId, this.naziv});

  factory Clanarina.fromJson(Map<String, dynamic> json) =>
      _$ClanarinaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ClanarinaToJson(this);
}
