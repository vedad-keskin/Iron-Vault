

import 'package:ironvault_mobile/models/korisnik.dart';

import 'package:json_annotation/json_annotation.dart';

part 'tracker.g.dart';

@JsonSerializable()
class Tracker {
  int? korisnikId;
  Korisnik? korisnik;

  int? ukupnoKupljeno;
  int? ukupnoPrisutava;


  Tracker();

  factory Tracker.fromJson(Map<String, dynamic> json) =>
      _$TrackerFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TrackerToJson(this);
}
