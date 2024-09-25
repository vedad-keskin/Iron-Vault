import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ironvault_mobile/models/search_result.dart';
import 'package:ironvault_mobile/models/suplement.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';
import 'package:ironvault_mobile/utils/app_constants.dart';

class SuplementProvider extends BaseProvider<Suplement> {
  SuplementProvider() : super("Suplement");

  @override
  Suplement fromJson(data) {
    return Suplement.fromJson(data);
  }

 Future<List<Suplement>> Recommend(int id) async {
  var url = const String.fromEnvironment("baseUrl",
      defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");

  url += 'Suplement/$id/recommend';

  print(url);

  var uri = Uri.parse(url);
  var headers = createHeaders();

  var response = await http.get(uri, headers: headers);

  if (isValidResponse(response)) {
    var data = jsonDecode(response.body) as List; // Decode as List
    // Map the JSON data to a List of Suplement objects
    return data.map((item) => Suplement.fromJson(item)).toList();
  } else {
    throw Exception("Nepoznat problem");
  }
}
}
