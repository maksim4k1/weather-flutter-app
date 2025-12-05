import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab6/models/days_weather.dart';
import 'package:lab6/models/now_weather.dart';
import 'package:lab6/requests/api.dart';
import 'package:lab6/screens/cubit/city_weather_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit() : super(CityWeatherLoadingState());

  Future<String> getCity() async {
    final prefs = await SharedPreferences.getInstance();
    final String city = prefs.getString('city') ?? "Томск";

    return city;
  }

  Future<void> loadData() async {
    try {
      final String city = await getCity();

      Map<String, dynamic> now_api_data = await getNowWeatherData(city);
      NowWeather now_weather = NowWeather.fromJson(now_api_data);

      Map<String, dynamic> days_api_data = await getDaysWeatherData(city);
      DaysWeather days_weather = DaysWeather.fromJson(days_api_data);

      emit(CityWeatherLoadedState(now_weather: now_weather, days_weather: days_weather));
    } catch(e) {
      emit(CityWeatherErrorState());
      return;
    }
  }

  Future<bool> changeCity(String newCity) async {
    try {
      Map<String, dynamic> now_api_data = await getNowWeatherData(newCity);
      NowWeather now_weather = NowWeather.fromJson(now_api_data);

      Map<String, dynamic> days_api_data = await getDaysWeatherData(newCity);
      DaysWeather days_weather = DaysWeather.fromJson(days_api_data);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('city', newCity);

      emit(CityWeatherLoadedState(now_weather: now_weather, days_weather: days_weather));

      return true;
    } catch(e) {
      return false;
    }
  }
}
