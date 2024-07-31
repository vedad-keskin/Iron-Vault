import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class SuplementProvider extends BaseProvider<Suplement> {
  SuplementProvider() : super("Suplement");

  @override
  Suplement fromJson(data) {
    return Suplement.fromJson(data);
  }
}
