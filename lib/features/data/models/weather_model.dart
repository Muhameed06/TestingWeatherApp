class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String country;
  final DateTime sunrise;
  final DateTime sunset;
  final double windSpeed;
  final double tempMax;
  final double tempMin;
  final int humidity;
  final int pressure;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      final cityName = json['name'] as String? ?? 'Unknown';
      final temperature = (json['main']['temp'] as num?)?.toDouble() ?? 0.0;
      final mainCondition = (json['weather'] as List<dynamic>?)?.first['main'] as String? ?? 'Unknown';
      final country = json['sys']['country'] as String? ?? 'Unknown';
      final sunrise = DateTime.fromMillisecondsSinceEpoch( (json['sys']['sunrise'] as int?)! * 1000);
      final sunset = DateTime.fromMillisecondsSinceEpoch( (json['sys']['sunset'] as int?)! * 1000);
      final windSpeed = (json['wind']['speed'] as num?)?.toDouble() ?? 0.0;
      final tempMax = (json['main']['temp_max'] as num?)?.toDouble() ?? 0.0;
      final tempMin = (json['main']['temp_min'] as num?)?.toDouble() ?? 0.0;
      final humidity = json['main']['humidity'] as int? ?? 0;
      final pressure = json['main']['pressure'] as int? ?? 0;

      return Weather(
        cityName: cityName,
        temperature: temperature,
        mainCondition: mainCondition,
        country: country,
        sunrise: sunrise,
        sunset: sunset,
        windSpeed: windSpeed,
        tempMax: tempMax,
        tempMin: tempMin,
        humidity: humidity,
        pressure: pressure,
      );
    } catch (e) {
      throw FormatException('Error parsing Weather data: $e');
    }
  }
}
