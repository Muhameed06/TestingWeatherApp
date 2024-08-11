import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/data/models/settings_item_model.dart';
import 'package:weather_app/features/presentation/bloc/weather_bloc.dart';

class SettingsRow extends StatefulWidget {
  const SettingsRow({super.key, required this.item});

  final SettingsItem item;

  @override
  State<SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = context.read<WeatherBloc>().currentUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 42.0,
                height: 42.0,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  gradient: widget.item.background,
                ),
                child: widget.item.icon,
              ),
              const SizedBox(width: 12),
              Text(
                context.read<WeatherBloc>().currentUnit ? 'Celsius' : 'Kelvin',
              ),
            ],
          ),
        ),
        Switch(
          activeColor: Colors.blue,
          value: context.read<WeatherBloc>().currentUnit,
          onChanged: (value) {
            final currentState = context.read<WeatherBloc>().state;
            setState(() {
              isSwitched = value;
            });

            if (currentState is WeatherSettingsState) {
              context.read<WeatherBloc>().add(value
                  ? WeatherUnitToCelciusEvent(currentState.weather)
                  : WeatherUnitToFarenheitEvent(currentState.weather));
            }
          },
        ),
      ],
    );
  }
}
