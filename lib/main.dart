import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/theme.dart';
import 'package:weather_app/features/data/datasources/weather_data_source.dart';
import 'package:weather_app/features/data/repositories/weather_repository_implementation.dart';
import 'package:weather_app/features/domain/services/weather_service.dart';
import 'package:weather_app/features/domain/usecases/get_weather.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/presentation/pages/settings_page.dart';
import 'package:weather_app/features/presentation/pages/weather_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.darkThemeMode,
    home: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => WeatherBloc(
                  getWeather: WeatherUsecase(WeatherRepositoryImplementation(
                      WeatherDataSourceImplementation(
                          WeatherService('1349d6c14f8d1a4929c9a1b5301fb469')))),
                ))
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isCelcius = context.read<WeatherBloc>().currentUnit;
    context.read<WeatherBloc>().add(WeatherInitializeEvent(null, isCelcius));
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitialState) {
          return const WeatherPage();
        } else if (state is WeatherSuccessState) {
          return const WeatherPage();
        } else if (state is WeatherSettingsState) {
          return const SettingsPage();
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
