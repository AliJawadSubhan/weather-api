import 'package:flutter/material.dart';

import '../utilities/const.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  TextEditingController citycontroller = TextEditingController();

  String? cityName;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.deepOrange[200],
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: citycontroller,
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    contentPadding: const EdgeInsets.all(12),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'City Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (newvalue) {
                    cityName = newvalue;
                    print("City: $cityName");
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: null,
              ),
              TextButton(
                onPressed: ()  {
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
