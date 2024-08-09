import 'package:flutter/material.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/domain/services/weather_service.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('1349d6c14f8d1a4929c9a1b5301fb469');
  final _cityController = TextEditingController(); // Add a controller
  Weather? _weather;

  _fetchWeather() async {
    String cityName = _cityController.text; // Get the city name from the text field

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: 'Search city...',
              ),
            ),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Get Weather'),
            ),
            Text(_weather?.cityName ?? ''),
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}
