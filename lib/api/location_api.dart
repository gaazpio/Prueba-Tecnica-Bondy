import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba_tecnica_bondy/models/location.dart';

class LocationApi {
  static const endpoint = "https://geocoding-api.open-meteo.com/v1/search";

  Future<List<Location>> searchLocation(String searchTerms) async {
    try {
      final response = await http.get(
        Uri.parse(endpoint).replace(queryParameters: {
          'name': searchTerms,
          'count': '3',
          'language': 'en',
          'format': 'json',
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final results = jsonDecode(response.body)['results'] as List<dynamic>;
        return results.map((result) => Location.fromJson(result)).toList();
      }

      return [];
    } catch (e) {
      print("Error while fetching searchLocation. $e");
      return [];
    }
  }
}
