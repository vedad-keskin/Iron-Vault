import 'package:ironvault_desktop/models/faq.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class FaqProvider extends BaseProvider<Faq> {
  FaqProvider(): super("Faq");

  @override
  Faq fromJson(data) {
    return Faq.fromJson(data);
  }
}