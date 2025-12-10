import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab6/models/weather_list.dart';
import 'package:lab6/screens/city_screen.dart';
import 'package:lab6/screens/cubit/city_weather_cubit.dart';
import 'package:lab6/screens/cubit/city_weather_state.dart';
import 'package:lab6/screens/widgets/current_weather_card.dart';
import 'package:lab6/screens/widgets/forecast_list.dart';
import 'package:lab6/utils/weather_utils.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade700,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  'WeatherApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.location_city,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityScreen(),
                  ),
                );
              },
              tooltip: 'Сменить город',
            ),
          ],
        ),
        centerTitle: false,
        toolbarHeight: 70,
      ),
      body: Screen(),
    );
  }
}

class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityWeatherCubit, CityWeatherState>(
      builder: (context, state) {
        if (state is CityWeatherLoadingState) {
          BlocProvider.of<CityWeatherCubit>(context).loadData();
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CityWeatherLoadedState) {
          final nowWeather = state.now_weather;
          final daysWeather = state.days_weather;

          Map<String, List<WeatherList>> forecastByDay = {};
          if (daysWeather != null && daysWeather.list != null) {
            forecastByDay = WeatherUtils.groupWeatherByDay(
              daysWeather.list!,
              (forecast) => forecast.dt!,
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                CurrentWeatherCard(
                  nowWeather: nowWeather,
                  sunriseTime: DateTime.fromMillisecondsSinceEpoch(
                    nowWeather.sys!.sunrise! * 1000,
                  ),
                  sunsetTime: DateTime.fromMillisecondsSinceEpoch(
                    nowWeather.sys!.sunset! * 1000,
                  ),
                  formatTime: WeatherUtils.formatDateTime,
                  getWeatherEmoji: WeatherUtils.getWeatherEmoji,
                ),

                ForecastList(forecastByDay: forecastByDay),
              ],
            ),
          );
        }

        if (state is CityWeatherErrorState) {
          return const Center(child: Text("Произошла ошибка"));
        }

        return Container();
      },
    );
  }
}
