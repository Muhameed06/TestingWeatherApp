import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:weather_app/core/helpers/get_current_date.dart';
import 'package:weather_app/core/helpers/get_current_weather_image.dart';
import 'package:weather_app/core/helpers/weather_unit_convertions.dart';
import 'package:weather_app/features/data/models/weather_model.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/presentation/widgets/weather_details.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  Weather? weather;

                  if (state is WeatherSuccessState) {
                    if (state.weather != null) {
                      weather = state.weather!;
                    }
                  }

                  final isCelcius = context.read<WeatherBloc>().currentUnit;

                  return RefreshIndicator(
                    onRefresh: () async {
                      if (_cityController.text.isNotEmpty) {
                        context
                            .read<WeatherBloc>()
                            .add(WeatherFetchEvent(_cityController.text));
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
                                      )),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: const HugeIcon(
                                        icon: HugeIcons.strokeRoundedSettings01,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        final currentState =
                                            context.read<WeatherBloc>().state;
                                        final currentUnit = context
                                            .read<WeatherBloc>()
                                            .currentUnit;
                                        print(
                                            "Muhamed current unit in main page ${currentUnit}");
                                        if (currentState
                                            is WeatherSuccessState) {
                                          context.read<WeatherBloc>().add(
                                              WeatherSettingsEvent(currentUnit,
                                                  currentState.weather));
                                        } else {
                                          context.read<WeatherBloc>().add(
                                              WeatherSettingsEvent(
                                                  currentUnit, null));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _cityController,
                                decoration: const InputDecoration(
                                  hintText: 'Search city...',
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 56, 56, 61),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    fixedSize: Size(buttonWidth, 50)),
                                onPressed: () async {
                                  if (_cityController.text != '') {
                                    context.read<WeatherBloc>().add(
                                        WeatherFetchEvent(
                                            _cityController.text));
                                  }
                                },
                                child: const Text(
                                  'Get Weather',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                    height: 300),
                                Text(
                                  isCelcius
                                      ? '${kelvinToCelsius(weather.temperature.round())}°C'
                                      : '${celciusToKelvin(weather.temperature.round())}°K',
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
                                const SizedBox(
                                  height: 10,
                                ),
                                WeatherDetailsCard(weather: weather),
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
