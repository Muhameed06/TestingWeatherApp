part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {
  const WeatherEvent();
}

final class WeatherInitializeEvent extends WeatherEvent {
  final Weather? weather;
  final bool isCelcius;
  const WeatherInitializeEvent(this.weather, this.isCelcius);
}

final class WeatherFetchEvent extends WeatherEvent {
  final String cityName;
  const WeatherFetchEvent(this.cityName);
}

final class WeatherSettingsEvent extends WeatherEvent {
  final bool isCelcius;
  final Weather? weather;
  const WeatherSettingsEvent(this.isCelcius, this.weather);
}

final class WeatherUnitToCelciusEvent extends WeatherEvent {
  final Weather? weather;
  const WeatherUnitToCelciusEvent(this.weather);
}

final class WeatherUnitToFarenheitEvent extends WeatherEvent {
  final Weather? weather;
  const WeatherUnitToFarenheitEvent(this.weather);
}

final class WeatherRefreshEvent extends WeatherEvent {
  final Weather? weather;
  const WeatherRefreshEvent(this.weather);
}
