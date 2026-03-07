
import 'package:ironvault_desktop/models/prisustvo.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class PrisustvoProvider extends BaseProvider<Prisustvo> {
  PrisustvoProvider(): super("Prisustvo");

  @override
  Prisustvo fromJson(data) {
    return Prisustvo.fromJson(data);
  }
}