import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/data/models/weather_model.dart';

abstract interface class WeatherRepository {
  Future<Either<Failure, Weather>> getWeather({required String cityName});
}