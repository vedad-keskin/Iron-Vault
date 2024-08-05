

import 'package:ironvault_desktop/models/grad.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class GradProvider extends BaseProvider<Grad> {
  GradProvider(): super("Grad");

  @override
  Grad fromJson(data) {
    return Grad.fromJson(data);
  }
}