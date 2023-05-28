import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/colors.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _weatherInfo = '';

  void getWeather(String city) async {
    final apiUrl = 'https://goweather.herokuapp.com/weather/$city';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        displayWeather(weatherData);
      } else {
        setState(() {
          _weatherInfo = 'An error occurred while fetching weather data.';
        });
      }
    } catch (error) {
      setState(() {
        _weatherInfo = 'An error occurred while fetching weather data.';
      });
    }
  }

  void displayWeather(dynamic weatherData) {
    final temperature = weatherData['temperature'];
    final wind = weatherData['wind'];
    final description = weatherData['description'];
    final forecast = weatherData['forecast'];

    setState(() {
      _weatherInfo = '''
        Description: $description
        Current Temperature: $temperature
        Wind Speed: $wind
        3-Day Forecast:
      ''';

      for (var day in forecast) {
        final dayNumber = day['day'];
        final dayTemperature = day['temperature'];
        final dayWind = day['wind'];

        _weatherInfo += '\nDay $dayNumber: Temperature: $dayTemperature, Wind: $dayWind';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Weather App'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter City',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary
                ),
                onPressed: () {
                  final city = _cityController.text;
                  getWeather(city);
                },
                child: Text('Check Weather Info'),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _weatherInfo,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}