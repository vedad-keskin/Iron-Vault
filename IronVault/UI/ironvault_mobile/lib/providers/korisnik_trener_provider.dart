
import 'package:ironvault_mobile/models/korisnik_trener.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class KorisnikTrenerProvider extends BaseProvider<KorisnikTrener> {
  KorisnikTrenerProvider(): super("KorisnikTrener");

  @override
  KorisnikTrener fromJson(data) {
    return KorisnikTrener.fromJson(data);
  }
}