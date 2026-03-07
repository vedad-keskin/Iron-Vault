import 'package:ironvault_mobile/models/clanarina.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnik_clanarina.g.dart';

@JsonSerializable()
class KorisnikClanarina {
  int? korisnikClanarinaId;
  int? korisnikId;
  int? clanarinaId;
  Clanarina? clanarina;
  DateTime? datumUplate;
  DateTime? datumIsteka;

  KorisnikClanarina({this.korisnikClanarinaId});

  factory KorisnikClanarina.fromJson(Map<String, dynamic> json) =>
      _$KorisnikClanarinaFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisnikClanarinaToJson(this);
}
