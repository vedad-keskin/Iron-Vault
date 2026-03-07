
import 'package:ironvault_desktop/models/clanarina.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class ClanarinaProvider extends BaseProvider<Clanarina> {
  ClanarinaProvider(): super("Clanarina");

  @override
  Clanarina fromJson(data) {
    return Clanarina.fromJson(data);
  }
}