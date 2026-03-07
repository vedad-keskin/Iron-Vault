
import 'package:ironvault_mobile/models/clanarina.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class ClanarinaProvider extends BaseProvider<Clanarina> {
  ClanarinaProvider(): super("Clanarina");

  @override
  Clanarina fromJson(data) {
    return Clanarina.fromJson(data);
  }
}