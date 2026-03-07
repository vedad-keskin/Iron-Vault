

import 'package:ironvault_desktop/models/spol.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class SpolProvider extends BaseProvider<Spol> {
  SpolProvider(): super("Spol");

  @override
  Spol fromJson(data) {
    return Spol.fromJson(data);
  }
}