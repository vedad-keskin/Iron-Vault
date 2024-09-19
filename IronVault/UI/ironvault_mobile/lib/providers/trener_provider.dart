
import 'package:ironvault_mobile/models/trener.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class TrenerProvider extends BaseProvider<Trener> {
  TrenerProvider(): super("Trener");

  @override
  Trener fromJson(data) {
    return Trener.fromJson(data);
  }
}