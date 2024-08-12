import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:weather_app/core/helpers/get_current_date.dart';
import 'package:weather_app/core/helpers/get_current_weather_image.dart';
import 'package:weather_app/core/helpers/weather_unit_convertions.dart';
import 'package:weather_app/core/utilities/dialogs/city_not_found_dialog.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/presentation/widgets/weather_details.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String? cityName = '';

  @override
  Widget build(BuildContext context) {
    final WeatherBloc bloc = context.read<WeatherBloc>();
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  final Weather? weather =
                      state is WeatherSuccessState ? state.weather : null;
                  final bool isCelsius = bloc.currentUnit;

                  if (state is WeatherFailureState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      if (state is WeatherSuccessState && cityName != null) {
                        bloc.add(WeatherFetchEvent(cityName!));
                        getFormattedDateTime();
                      }
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Good Morning",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: const HugeIcon(
                                        icon: HugeIcons.strokeRoundedSettings01,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        final WeatherState currentState =
                                            bloc.state;
                                        final bool currentUnit =
                                            bloc.currentUnit;
                                        bloc.add(
                                          WeatherSettingsEvent(
                                            currentUnit,
                                            currentState is WeatherSuccessState
                                                ? currentState.weather
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: cityController,
                                decoration: const InputDecoration(
                                  hintText: 'Search city...',
                                ),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 56, 56, 61),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.9,
                                      50),
                                ),
                                onPressed: () {
                                  if (cityController.text.isNotEmpty) {
                                    cityName = cityController.text;
                                    bloc.add(
                                        WeatherFetchEvent(cityController.text));
                                  } else {
                                    showErrorDialog(context,
                                        'Please type the name of the city');
                                  }
                                },
                                child: const Text(
                                  'Get Weather',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 15),
                              if (weather != null) ...[
                                Text(
                                  weather.cityName,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  getWeatherImage(weather.mainCondition),
                                  width: 300,
                                  height: 300,
                                ),
                                Text(
                                  isCelsius
                                      ? '${kelvinToCelsius(weather.temperature).round()}°C'
                                      : '${kelvinToFahrenheit(weather.temperature).round()}°F',
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  weather.mainCondition,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(getFormattedDateTime()),
                                const SizedBox(height: 10),
                                WeatherDetailsCard(
                                  weather: weather,
                                  isCelsius: isCelsius,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
