import 'package:lab6/models/days_weather.dart';
import 'package:lab6/models/now_weather.dart';

abstract class CityWeatherState{}

class CityWeatherLoadingState extends CityWeatherState {}

class CityWeatherLoadedState extends CityWeatherState {
  NowWeather now_weather;
  DaysWeather days_weather;

  CityWeatherLoadedState({required this.now_weather, required this.days_weather});
}

class CityWeatherErrorState extends CityWeatherState {}

