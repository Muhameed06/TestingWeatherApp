part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {
  const WeatherState();
}

final class WeatherInitialState extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}

final class WeatherSuccessState extends WeatherState {
  final Weather? weather;
  const WeatherSuccessState(this.weather);
}

final class WeatherFailureState extends WeatherState {
  final String message;
  const WeatherFailureState(this.message);
}

final class WeatherSettingsState extends WeatherState {
  final bool isCelcius;
  final Weather? weather;
  const WeatherSettingsState(this.isCelcius, this.weather);
}
