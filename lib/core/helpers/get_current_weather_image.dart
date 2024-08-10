String getWeatherImage(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
        return 'assets/8.png';
      case 'fog':
        return 'assets/5.png';
      case 'rain':
        return 'assets/3.png';
      case 'drizzle':
        return 'assets/2.png';
      case 'thunderstorm':
        return 'assets/1.png';
      case 'clear':
        return 'assets/11.png';
      case 'haze':
        return 'assets/5.png';
      default:
        return 'assets/11.png';
    }
  }