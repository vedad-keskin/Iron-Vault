import 'dart:convert';

import 'package:ironvault_mobile/models/narudzba.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';
import 'package:ironvault_mobile/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class NarudzbaProvider extends BaseProvider<Narudzba> {
  NarudzbaProvider() : super("Narudzba");

  @override
  Narudzba fromJson(data) {
    return Narudzba.fromJson(data);
  }

  Future<int> GetLatestOrderIdByUserId(int korisnikId) async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");

    url += 'Narudzba/$korisnikId/GetLatestOrderIdByUserId';

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

  if (isValidResponse(response)) {
    var data = response.body;

    // Try parsing the response body to an int
    try {
      return int.parse(data);
    } catch (e) {
      throw Exception("Failed to parse response as int: $e");
    }
  } else {
    throw Exception("Nepoznat problem");
  }
  }
}
