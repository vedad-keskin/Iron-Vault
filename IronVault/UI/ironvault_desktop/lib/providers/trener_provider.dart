
import 'package:ironvault_desktop/models/trener.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class TrenerProvider extends BaseProvider<Trener> {
  TrenerProvider(): super("Trener");

  @override
  Trener fromJson(data) {
    return Trener.fromJson(data);
  }
}