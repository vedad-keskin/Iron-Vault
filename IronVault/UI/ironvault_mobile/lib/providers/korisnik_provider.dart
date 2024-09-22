import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ironvault_mobile/models/korisnik.dart';
import 'package:ironvault_mobile/providers/base_provider.dart';
import 'package:ironvault_mobile/utils/app_constants.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  KorisnikProvider() : super("Korisnik");

  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

   Future<int> GetUserId(String username) async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");


    url += 'Korisnik/$username/getUserId';

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw new Exception("Nepoznat problem");
    }
  }



}
