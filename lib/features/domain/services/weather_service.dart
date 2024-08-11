import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/data/models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService(this.apiKey);

  //MARK: - Fetches the weather for given city
  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metrics'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      final errorMessage = _getErrorMessage(response.statusCode);
      throw ServerException(errorMessage);
    }
  }

  //MARK: - Checks the other status codes and gives back the message error
  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please check your API key.';
      case 404:
        return 'City not found. Please check the city name.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Unexpected error occurred. Status code: $statusCode';
    }
  }
}
