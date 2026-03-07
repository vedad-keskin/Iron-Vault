import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ironvault_desktop/models/biznis_report.dart';
import 'package:ironvault_desktop/providers/base_provider.dart';
import 'package:ironvault_desktop/utils/app_constants.dart';

class BiznisReportProvider extends BaseProvider<BizniReport> {
  BiznisReportProvider() : super("BiznisReport");

  @override
  BizniReport fromJson(data) {
    return BizniReport.fromJson(data);
  }

  Future<BizniReport> GetBiznisReport() async {
    var url = const String.fromEnvironment("baseUrl",
        defaultValue: "${AppConstants.baseUrl}${AppConstants.apiPort}/");


    url += 'GetReport';

    print(url);

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Nepoznat problem");
    }
  }

}
