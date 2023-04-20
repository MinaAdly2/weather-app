import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double minTemp;
  double maxTemp;
  String weatherCondition;
  String icon;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherCondition,
    required this.icon,
  });

  factory WeatherModel.fromJson(data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    return WeatherModel(
      date: DateTime.parse(data['location']['localtime']),
      temp: jsonData['avgtemp_c'],
      minTemp: jsonData['mintemp_c'],
      maxTemp: jsonData['maxtemp_c'],
      weatherCondition: jsonData['condition']['text'],
      icon: jsonData['condition']['icon'],
    );
  }

  String getImage() {
    if (weatherCondition == 'Clear' || weatherCondition == 'Light Cloud') {
      return 'assets/images/clear.png';
    } else if (weatherCondition == 'Sleet' ||
        weatherCondition == 'Snow' ||
        weatherCondition == 'Hail') {
      return 'assets/images/snow.png';
    } else if (weatherCondition == 'Heavy Cloud' ||
        weatherCondition == 'Partly cloudy' ||
        weatherCondition == 'Overcast') {
      return 'assets/images/cloudy.png';
    } else if (weatherCondition == 'Light Rain' ||
        weatherCondition == 'Heavy Rain' ||
        weatherCondition == 'Patchy rain possible' ||
        weatherCondition == 'Moderate rain' ||
        weatherCondition == 'Showers') {
      return 'assets/images/rainy.png';
    } else if (weatherCondition == 'Thunderstorm' ||
        weatherCondition == 'Thunder') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getThemeColor() {
    if (weatherCondition == 'Clear' || weatherCondition == 'Light Cloud') {
      return Colors.orange;
    } else if (weatherCondition == 'Sleet' ||
        weatherCondition == 'Snow' ||
        weatherCondition == 'Hail') {
      return Colors.blue;
    } else if (weatherCondition == 'Heavy Cloud' ||
        weatherCondition == 'Overcast') {
      return Colors.blueGrey;
    } else if (weatherCondition == 'Light Rain' ||
        weatherCondition == 'Heavy Rain' ||
        weatherCondition == 'Patchy rain possible' ||
        weatherCondition == 'Moderate rain' ||
        weatherCondition == 'Showers') {
      return Colors.blue;
    } else if (weatherCondition == 'Thunderstorm' ||
        weatherCondition == 'Thunder') {
      return Colors.cyan;
    } else {
      return Colors.orange;
    }
  }

  @override
  String toString() {
    return 'date = $date , temp = $temp, maxTemp = $maxTemp';
  }
}
