import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int? id;
  final String? name;
  final String? timezone;
  final String? country;
  final String? admin1;
  final String? admin2;
  final String? admin3;
  final int? population;
  final String? countryCode;
  final double? latitude;
  final double? longitude;

  const Location({
    required this.id,
    required this.name,
    required this.timezone,
    required this.country,
    required this.admin1,
    required this.admin2,
    required this.admin3,
    required this.population,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        timezone = json['timezone'],
        country = json['country'],
        countryCode = json['country_code'],
        admin1 = json['admin1'],
        admin2 = json['admin2'],
        admin3 = json['admin3'],
        population = json['population'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  @override
  List<Object?> get props => [
        id,
        name,
        timezone,
        country,
        admin1,
        admin2,
        admin3,
        population,
        countryCode,
        latitude,
        longitude,
      ];
}
