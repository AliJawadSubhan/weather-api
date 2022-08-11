// import 'dart:convert';

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:realclimate/screens/city_screen.dart';
import 'package:realclimate/services/weather.dart';
import '../utilities/const.dart';

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key, required this.locationweather}) : super(key: key);

  var locationweather;
  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int? temperature;
  int? conditionNum;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;

  @override
  void initState() {
    updateUI( widget.locationweather);
    super.initState();
    // print(safe);
  }

  
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      conditionNum = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(conditionNum);
      weatherMessage = '${weatherModel.getMessage(temperature!)} $cityName';
      // print(temperature);
    });
  }
  var image = "images/cloudy.png";

  @override
  build(context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        color: Colors.blue[50],
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () {
                      setState(() {
                        updateUI( widget.locationweather);
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (typedName != null) {
                        var weatherData = await weatherModel.getCityWeather(typedName);
                        print(weatherData);
                        setState(() {
                          updateUI( weatherData);
                        });
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                  ),
                  Text(
                    "$weatherIcon",
                    style: kConditionTextStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
