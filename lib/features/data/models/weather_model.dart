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

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required this.country,
      required this.sunrise,
      required this.sunset,
      required this.windSpeed,
      required this.tempMax,
      required this.tempMin,
      required this.humidity,
      required this.pressure});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        country: json['sys']['country'],
        sunrise:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        sunset:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
        windSpeed: json['wind']['speed'].toDouble(),
        tempMax: json['main']['temp_max'].toDouble(),
        tempMin: json['main']['temp_min'].toDouble(),
        humidity: json['main']['humidity'],
        pressure: json['main']['pressure']);
  }
}
