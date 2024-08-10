import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:weather_app/core/theme/app_pallete.dart';
import 'package:weather_app/features/data/models/weather_model.dart';

class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white30),
                  height: 2,
                  margin: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildCard(
                    'Max',
                    HugeIcons.strokeRoundedTemperature,
                    '${weather.tempMax}°C',
                  )),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _buildCard(
                    'Wind',
                    HugeIcons.strokeRoundedFastWind,
                    '${weather.windSpeed} km/h',
                  )),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _buildCard(
                    'Humidity',
                    HugeIcons.strokeRoundedHumidity,
                    '${weather.humidity}%',
                  )),
                ],
              ),
              const SizedBox(height: 8),
              // Second Row of Cards
              Row(
                children: [
                  Expanded(
                      child: _buildCard('Pressure',
                          HugeIcons.strokeRoundedDashboardSpeed01, '${weather.pressure} in')),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _buildCard(
                          'Sunrise', HugeIcons.strokeRoundedSun01,'${weather.sunrise.hour.toString().padLeft(2, '0')}:${weather.sunrise.minute.toString().padLeft(2, '0')}')),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _buildCard(
                          'Sunset', HugeIcons.strokeRoundedMoon, '${weather.sunset.hour.toString().padLeft(2, '0')}:${weather.sunset.minute.toString().padLeft(2, '0')}')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, String label1) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.white30, width: 2),
      ),
      color: AppPallete.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(label1, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
