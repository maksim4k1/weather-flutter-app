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
          // Красивый заголовок с градиентом
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
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                // Иконка в круге
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.timeline,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Текст
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Прогноз на ${forecastByDay.length} дней",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Подробный почасовой прогноз",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Контейнер для карточек с тенью
          if (forecastByDay.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // Карточки прогноза
                  ...forecastByDay.entries.map((entry) {
                    final forecasts = entry.value;
                    final firstForecast = forecasts.first;

                    // Рассчитываем мин и макс температуру
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
