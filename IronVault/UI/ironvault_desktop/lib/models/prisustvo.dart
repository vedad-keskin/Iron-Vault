import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prisustvo.g.dart';

@JsonSerializable()
class Prisustvo {
  int? prisustvoId;
  int? korisnikId;
  Korisnik? korisnik;
  DateTime? datumVrijemeUlaska;
  DateTime? datumVrijemeIzlaska;

  Prisustvo({this.prisustvoId});

  factory Prisustvo.fromJson(Map<String, dynamic> json) =>
      _$PrisustvoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PrisustvoToJson(this);
}
