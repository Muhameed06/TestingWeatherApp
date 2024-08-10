import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/domain/repository/weather_repository.dart';

class WeatherUsecase implements Usecase<Weather, GetWeatherParams> {
  final WeatherRepository weatherRepository;
  const WeatherUsecase(this.weatherRepository);

  @override
  Future<Either<Failure, Weather>> call(GetWeatherParams? params) async {
    return await weatherRepository.getWeather(cityName: params?.cityName ?? '');
  }
}

class GetWeatherParams {
  final String cityName;

  GetWeatherParams({required this.cityName});
}
