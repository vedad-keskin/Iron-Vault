

import 'package:ironvault_desktop/models/narudzba_stavka.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class NarudzbaStavkaProvider extends BaseProvider<NarudzbaStavka> {
  NarudzbaStavkaProvider(): super("NarudzbaStavka");

  @override
  NarudzbaStavka fromJson(data) {
    return NarudzbaStavka.fromJson(data);
  }
}