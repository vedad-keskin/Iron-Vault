import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/suplement_provider.dart';

class LoggedSuplementProvider extends SuplementProvider {
  @override
  Future<SearchResult<Suplement>> get({filter}) {
    print("im in logged suplement provider");

    return super.get(filter: filter);
  }
}
