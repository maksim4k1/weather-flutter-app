import 'package:flutter/material.dart';
import 'package:lab6/models/weather_list.dart';
import 'package:lab6/screens/widgets/forecast_card.dart';
import 'package:lab6/utils/weather_utils.dart';

class ForecastList extends StatelessWidget {
  final Map<String, List<WeatherList>> forecastByDay;

  const ForecastList({
    Key? key,
    required this.forecastByDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 30),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6A11CB),
                  Color(0xFF2575FC),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Прогноз на ${forecastByDay.length} дней",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          if (forecastByDay.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ...forecastByDay.entries.map((entry) {
                    final forecasts = entry.value;
                    final firstForecast = forecasts.first;

                    double minTemp = forecasts.map((f) => f.main!.temp!).reduce((a, b) => a < b ? a : b);
                    double maxTemp = forecasts.map((f) => f.main!.temp!).reduce((a, b) => a > b ? a : b);
                    final minTempC = (minTemp - 273.15).floor();
                    final maxTempC = (maxTemp - 273.15).floor();

                    return ForecastCard(
                      forecasts: forecasts,
                      dayKey: entry.key,
                      minTempC: minTempC,
                      maxTempC: maxTempC,
                      weatherEmoji: WeatherUtils.getWeatherEmoji(firstForecast.weather![0].main!),
                    );
                  }).toList(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
