import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/domain/usecases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUsecase _getWeather;
  bool _isCelcius = true; // Default value

  WeatherBloc({required WeatherUsecase getWeather})
      : _getWeather = getWeather,
        super(WeatherInitialState()) {
    on<WeatherInitializeEvent>(
      (event, emit) {
        _isCelcius = event.isCelcius;
        if (event.weather == null) {
          emit(WeatherInitialState());
        } else {
          emit(WeatherSuccessState(event.weather));
        }
      },
    );

    on<WeatherFetchEvent>(
      (event, emit) async {
        final response =
            await _getWeather(GetWeatherParams(cityName: event.cityName));
        response.fold(
          (failure) => emit(WeatherFailureState(failure.message)),
          (weather) => emit(WeatherSuccessState(weather)),
        );
      },
    );

    on<WeatherSettingsEvent>(
      (event, emit) async {
        _isCelcius = event.isCelcius;
        final currentState = state;
        if (currentState is WeatherSuccessState) {
          emit(WeatherSettingsState(_isCelcius, currentState.weather));
        } else {
          emit(WeatherSettingsState(_isCelcius, null));
        }
      },
    );

    on<WeatherUnitToCelciusEvent>(
      (event, emit) async {
        _isCelcius = true;
        final currentState = state;
        print("State kur e qesum celcius ${currentState}");
        emit(WeatherSettingsState(true, event.weather));
      },
    );

    on<WeatherUnitToFarenheitEvent>(
      (event, emit) async {
        _isCelcius = false;
        final currentState = state;
        print("State kur e qesum kalvin ${currentState}");
        emit(WeatherSettingsState(false, event.weather));
      },
    );
  }

  bool get currentUnit => _isCelcius; // Getter to access the current unit
}
