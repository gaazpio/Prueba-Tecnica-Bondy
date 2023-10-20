import 'package:flutter/material.dart';
import 'package:prueba_tecnica_bondy/models/location.dart';
import 'package:prueba_tecnica_bondy/models/weather.dart';

class WeatherInfoCard extends StatelessWidget {
  final WeatherExter weatherData;
  final Location locationData;

  const WeatherInfoCard({
    super.key,
    required this.weatherData,
    required this.locationData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'City: ${locationData.name}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Latitude: ${locationData.latitude}',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Longitude: ${locationData.longitude}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Temperature: ${weatherData.temperature}°F',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Wind Speed: ${weatherData.windSpeed} mph',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Wind Direction: ${weatherData.windDirection}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Time: ${weatherData.time}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
