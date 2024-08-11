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
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () async {
                final isCelcius = context.read<WeatherBloc>().currentUnit;

                if (state is WeatherSettingsState) {
                  context.read<WeatherBloc>().add(
                      WeatherInitializeEvent(state.weather, isCelcius));
                } else {
                  context
                      .read<WeatherBloc>()
                      .add(WeatherInitializeEvent(null, isCelcius));
                }
              },
              icon: const Icon(Icons.arrow_back),
            );
          },
        ),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [SettingsRow(item: settingsItem[0])],
        ),
      ),
    );
  }
}
