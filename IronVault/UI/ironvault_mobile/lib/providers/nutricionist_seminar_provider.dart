
import 'package:ironvault_mobile/models/nutricionist_seminar.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class NutricionistSeminarProvider extends BaseProvider<NutricionistSeminar> {
  NutricionistSeminarProvider(): super("NutricionistSeminar");

  @override
  NutricionistSeminar fromJson(data) {
    return NutricionistSeminar.fromJson(data);
  }
}