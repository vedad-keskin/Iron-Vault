import 'package:ironvault_desktop/models/recenzija.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class RecenzijaProvider extends BaseProvider<Recenzija> {
  RecenzijaProvider(): super("Recenzija");

  @override
  Recenzija fromJson(data) {
    return Recenzija.fromJson(data);
  }


}