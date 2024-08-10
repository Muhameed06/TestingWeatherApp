import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/domain/services/weather_service.dart';

abstract interface class WeatherDataSource {
  Future<Weather> getWeather({required String cityName});
  Future<String> getCurrentCity();
}

class WeatherDataSourceImplementation implements WeatherDataSource {
  final WeatherService service;
  WeatherDataSourceImplementation(this.service);

  @override
  Future<Weather> getWeather({required String cityName}) async {
    try {
      final response = await service.getWeather(cityName);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> getCurrentCity() {
    throw UnimplementedError();
  }
}
