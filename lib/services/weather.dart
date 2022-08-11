// import 'package:flutter/cupertino.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

import '../utilities/const.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(cityName) async {
    // String cityName = 'Singapore';
    NetworkHelper networkHelperLoc =
        NetworkHelper(url: '$api?q=$cityName&appid=$apiKey&units=metric');
   

    var weatherData = await networkHelperLoc.getData();

    return weatherData;
  }

  Future gettingWeather() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    NetworkHelper network = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=${loc.lattitude}&lon=${loc.longtitude}&appid=$apiKey&units=metric");
    var weatherData = network.getData();
    return weatherData;
  }

  getWeatherIcon(int? condition) {
    if (condition! < 300) {
      return '☁︎ ';
    } else if (condition < 400) {
      return '⛈️';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  getPicture(int? condition) {
    if (condition! > 1) {
      return "images/cloudy.png";
    }
  }
}
