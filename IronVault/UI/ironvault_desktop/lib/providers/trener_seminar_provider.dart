
import 'package:ironvault_desktop/models/trener_seminar.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';

class TrenerSeminarProvider extends BaseProvider<TrenerSeminar> {
  TrenerSeminarProvider(): super("TrenerSeminar");

  @override
  TrenerSeminar fromJson(data) {
    return TrenerSeminar.fromJson(data);
  }
}