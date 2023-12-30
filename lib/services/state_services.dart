import 'dart:convert';

import 'package:covid_19/api_models/world_state_api.dart';
import 'package:covid_19/services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateApi> getWorldApi() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateApi.fromJson(data);
    } else {
      throw Exception('Api not fecth');
    }
  }

  Future<List<dynamic>> getCountriesApi() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Api not fecth');
    }
  }
}
