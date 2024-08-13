
import 'package:ironvault_desktop/models/korisnik.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("Korisnik");

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

 


}
