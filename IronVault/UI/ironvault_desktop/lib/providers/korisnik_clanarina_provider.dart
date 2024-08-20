

import 'package:ironvault_desktop/models/korisnik_clanarina.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class KorisnikClanarinaProvider extends BaseProvider<KorisnikClanarina> {
  KorisnikClanarinaProvider(): super("KorisnikClanarina");

  @override
  KorisnikClanarina fromJson(data) {
    return KorisnikClanarina.fromJson(data);
  }
}