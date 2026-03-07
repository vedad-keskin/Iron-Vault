import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ironvault_desktop/models/suplement.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';
import 'package:ironvault_desktop/utils/app_constants.dart';

class SuplementProvider extends BaseProvider<Suplement> {
  SuplementProvider() : super("Suplement");

  @override
  Suplement fromJson(data) {
    return Suplement.fromJson(data);
  }

  Future<Suplement> Activate(int id) async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");


    url += 'Suplement/$id/activate';

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.put(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Nepoznat problem");
    }
  }

  Future<Suplement> Edit(int id) async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");


    url += 'Suplement/$id/edit';

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.put(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Nepoznat problem");
    }
  }


 Future<Suplement> Hide(int id) async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");


    url += 'Suplement/$id/hide';

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.put(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Nepoznat problem");
    }
  }


}
