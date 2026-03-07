
import 'package:ironvault_desktop/models/nutricionist.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class NutricionistProvider extends BaseProvider<Nutricionist> {
  NutricionistProvider(): super("Nutricionist");

  @override
  Nutricionist fromJson(data) {
    return Nutricionist.fromJson(data);
  }
}