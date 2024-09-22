
import 'package:ironvault_mobile/models/korisnik_nutricionist.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class KorisnikNutricionistProvider extends BaseProvider<KorisnikNutricionist> {
  KorisnikNutricionistProvider(): super("KorisnikNutricionist");

  @override
  KorisnikNutricionist fromJson(data) {
    return KorisnikNutricionist.fromJson(data);
  }
}