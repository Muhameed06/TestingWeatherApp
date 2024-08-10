import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/data/models/settings_item_model.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/presentation/widgets/settings_row.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherSettingsState) {
          print("muhamed ${state}");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              final currentState = context.read<WeatherBloc>().state;
              final isCelcius = context.read<WeatherBloc>().currentUnit;

              if (currentState is WeatherSettingsState) {
                print("Mir o ");
                print("Temperature ${currentState.weather?.temperature}");
                context.read<WeatherBloc>().add(
                    WeatherInitializeEvent(currentState.weather, isCelcius));
              } else {
                print("Keq o ");
                context
                    .read<WeatherBloc>()
                    .add(WeatherInitializeEvent(null, isCelcius));
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              final isCelcius = context.read<WeatherBloc>().currentUnit;
              return Text('Settings ${isCelcius ? "°C" : "°F"}');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [SettingsRow(item: settingsItem[0])],
          ),
        ),
      ),
    );
  }
}
