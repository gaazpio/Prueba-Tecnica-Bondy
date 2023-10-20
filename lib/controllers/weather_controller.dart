import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_bondy/api/location_api.dart';
import 'package:prueba_tecnica_bondy/api/weather_api.dart';
import 'package:prueba_tecnica_bondy/models/location.dart';
import 'package:prueba_tecnica_bondy/models/weather.dart';

class WeatherController extends GetxController {
  final LocationApi _locationApi = LocationApi();
  final WeatherApi _weatherApi = WeatherApi();

  final RxList<Location> searchLocations = RxList.empty();
  final Rx<Location?> locationSelected = Rx<Location?>(null);
  final Rx<WeatherExter?> currentWeather = Rx<WeatherExter?>(null);

  TextEditingController input = TextEditingController();

  // Function that fetches weather data based on location search terms
  Future<void> fetchLocations(String searchTerms) async {
    print("Fetching locations...");

    searchLocations.value = await _locationApi.searchLocation(searchTerms);
  }

  // Selects the location based on the index of the options presented to the user when searching in the search bar
  Future<void> setLocation(int index) async {
    locationSelected.value = searchLocations.value[index];
    currentWeather.value = await _weatherApi.getWeather(
        locationSelected.value?.latitude ?? 0,
        locationSelected.value?.longitude ?? 0);

    input.clear();
    searchLocations.value = [];
  }
}
