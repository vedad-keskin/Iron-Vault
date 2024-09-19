
import 'package:ironvault_mobile/models/seminar.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';

class SeminarProvider extends BaseProvider<Seminar> {
  SeminarProvider(): super("Seminar");

  @override
  Seminar fromJson(data) {
    return Seminar.fromJson(data);
  }
}