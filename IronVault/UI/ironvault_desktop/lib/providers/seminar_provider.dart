
import 'package:ironvault_desktop/models/seminar.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class SeminarProvider extends BaseProvider<Seminar> {
  SeminarProvider(): super("Seminar");

  @override
  Seminar fromJson(data) {
    return Seminar.fromJson(data);
  }
}