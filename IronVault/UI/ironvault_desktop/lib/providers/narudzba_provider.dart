

import 'package:ironvault_desktop/models/narudzba.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class NarudzbaProvider extends BaseProvider<Narudzba> {
  NarudzbaProvider(): super("Narudzba");

  @override
  Narudzba fromJson(data) {
    return Narudzba.fromJson(data);
  }
}