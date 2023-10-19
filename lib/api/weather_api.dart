import 'package:prueba_tecnica_bondy/models/weather.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherApi {
  static const endpoint = "https://api.open-meteo.com/v1/forecast";

  Future<Weather?> getWeather(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(endpoint).replace(queryParameters: {
          'latitude': lat.toString(),
          'longitude': lon.toString(),
          'current_weather': 'true'
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final results = jsonDecode(response.body);
        return Weather.fromJson(results['current_weather']);
      }

      return null;
    } catch (e) {
      print("Error while fetching weather. $e");
      return null;
    }
  }
}
