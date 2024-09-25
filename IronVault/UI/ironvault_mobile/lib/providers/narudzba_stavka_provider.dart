

import 'package:ironvault_mobile/models/narudzba_stavka.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class NarudzbaStavkaProvider extends BaseProvider<NarudzbaStavka> {
  NarudzbaStavkaProvider(): super("NarudzbaStavka");

  @override
  NarudzbaStavka fromJson(data) {
    return NarudzbaStavka.fromJson(data);
  }
}