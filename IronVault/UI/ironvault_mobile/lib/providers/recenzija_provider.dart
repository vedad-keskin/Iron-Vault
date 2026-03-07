import 'package:ironvault_mobile/models/recenzija.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class RecenzijaProvider extends BaseProvider<Recenzija> {
  RecenzijaProvider(): super("Recenzija");

  @override
  Recenzija fromJson(data) {
    return Recenzija.fromJson(data);
  }


}