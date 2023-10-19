import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_bondy/controllers/weather_controller.dart';
import 'package:prueba_tecnica_bondy/widgets/weather_card.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize weather controller
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: weatherController.input,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) async => Future.delayed(
                    const Duration(milliseconds: 150),
                    () async => await weatherController.fetchLocations(value)),
              ),
            ),
            Obx(
              () => weatherController.searchLocations.value.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: weatherController.searchLocations.value.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(weatherController
                                .searchLocations.value[index].name ??
                            ""),
                        onTap: () => weatherController.setLocation(index),
                      ),
                    ),
            ),
            Obx(
              () => weatherController.currentWeather.value == null
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text("No city selected."),
                    )
                  : WeatherInfoCard(
                      weatherData: weatherController.currentWeather.value!,
                      locationData: weatherController.locationSelected.value!,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
