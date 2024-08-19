### Weather App
This is a weather app built with Dart and Flutter. It allows users to check the weather and forecast for any city and provides a settings option to toggle between temperature units.
It was built using Clean Architecture and BLoC for State Management.

### Features

WeatherPage:

* Contains a text field where users can type the name of a city.
* Includes a button to fetch and display the current weather and forecast for the specified city.
* Displays the weather information including temperature and forecast.
* Provides access to the Settings screen through an icon above the text field.
  
Settings Screen:

* Features a toggle button to switch between Fahrenheit and Celsius units for temperature.
* The selected temperature unit is applied immediately upon toggling and is reflected on the WeatherPage.

### Instructions

| Command | Description |
| --- | --- |
| `git clone <repository-url>` | Cloning the Repository |
| `cd <project-directory>` | Navigating to the Project Directory |
| `flutter pub get` | Installing Dependencies |

### WeatherPage:

* Enter a city name in the text field and click the button to get the weather information.
* The weather details and forecast for the city will be displayed.
* Swipe up to refresh the data. Considering that weather doesn't change very often you can test refreshing with the current time above the temperature.
* If a wrong city name is typed an alert will show.
* If no city is entered at all, an alert will show.
* To access the settings, tap the settings icon located above the text field.
  
Settings Screen:

* Use the toggle button to switch between Fahrenheit and Celsius units.
* Changes to the temperature unit will be applied immediately and reflected when you return to the WeatherPage.

### Third party libraries

* http - For making network requests
* BLoC - For State Management
* fpdart - For Functional Dart Programming
* hugeicons - For icons


## License
This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to adjust any details as needed!

### Resources
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

