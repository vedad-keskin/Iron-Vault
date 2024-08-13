

import 'package:ironvault_desktop/models/korisnik_uloga.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class KorisnikUlogaProvider extends BaseProvider<KorisnikUloga> {
  KorisnikUlogaProvider(): super("KorisnikUloga");

  @override
  KorisnikUloga fromJson(data) {
    return KorisnikUloga.fromJson(data);
  }
}