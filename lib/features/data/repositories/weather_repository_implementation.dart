import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/data/datasources/weather_data_source.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/domain/repository/weather_repository.dart';

class WeatherRepositoryImplementation implements WeatherRepository {
  final WeatherDataSource remoteDataSource;
  const WeatherRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Either<Failure, Weather>> getWeather(
      {required String cityName}) async {
    try {
      final weather = await remoteDataSource.getWeather(cityName: cityName);
      return right(weather);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
