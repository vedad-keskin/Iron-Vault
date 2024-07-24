import 'package:ironvault_desktop/models/search_result.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/suplement_provider.dart';

class LoggedSuplementProvider extends SuplementProvider {
  @override
  Future<SearchResult<Suplement>> get({filter}) {
    
    print("im in logged suplement provider");

    return super.get(filter:filter);
  }
}