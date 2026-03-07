import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';
import 'package:ironvault_mobile/utils/app_constants.dart';
import 'package:ironvault_mobile/models/tracker.dart';

class TrackerProvider extends BaseProvider<Tracker> {
  TrackerProvider() : super("GetAllTracker");

  @override
  Tracker fromJson(data) {
    return Tracker.fromJson(data);
  }

  Future<SearchResult<Tracker>> GetAllTracker({dynamic filter}) async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");


    url += 'GetAllTracker';

      if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

  



    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
           var result = SearchResult<Tracker>();



      for (var item in data) {
        result.result.add(fromJson(item));
      }

      return result;


    } else {
      throw new Exception("Nepoznat problem");
    }
  }

}
