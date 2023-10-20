import 'package:equatable/equatable.dart';

class WeatherExter extends Equatable {
  final double temperature;
  final double windSpeed;
  final int windDirection;
  final DateTime time;

  WeatherExter.fromJson(Map<String, dynamic> json)
      : temperature = json['temperature'],
        windSpeed = json['windspeed'],
        windDirection = json['winddirection'],
        time = DateTime.parse(json['time']);

  @override
  List<Object?> get props => [temperature, windSpeed, windDirection, time];
}
