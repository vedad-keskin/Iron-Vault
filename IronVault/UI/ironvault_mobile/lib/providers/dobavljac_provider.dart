import 'package:ironvault_mobile/models/dobavljac.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class DobavljacProvider extends BaseProvider<Dobavljac> {
  DobavljacProvider() : super("Dobavljac");

  @override
  Dobavljac fromJson(data) {
    return Dobavljac.fromJson(data);
  }
}
