import 'package:flutter/material.dart';
import 'package:lab6/models/now_weather.dart';
import 'package:lab6/screens/widgets/weather_detail_card.dart';

class CurrentWeatherCard extends StatelessWidget {
  final NowWeather nowWeather;
  final DateTime sunriseTime;
  final DateTime sunsetTime;
  final String Function(DateTime) formatTime;
  final String Function(String) getWeatherEmoji;

  const CurrentWeatherCard({
    Key? key,
    required this.nowWeather,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.formatTime,
    required this.getWeatherEmoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${nowWeather.name!}, ${nowWeather.sys!.country}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // День/ночь
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              ((nowWeather.sys!.sunset! > nowWeather.dt!) &&
                  (nowWeather.sys!.sunrise! < nowWeather.dt!))
                  ? "🌞 День"
                  : "🌙 Ночь",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: 20),

          // Температура
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    getWeatherEmoji(nowWeather.weather![0].main!),
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),

              SizedBox(width: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${(nowWeather.main!.temp! - 273.15).floor()}°",
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    nowWeather.weather![0].description!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 30),

          // Детали погоды
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              WeatherDetailCard(
                icon: Icons.wb_sunny,
                title: "Восход",
                value: formatTime(sunriseTime),
                color: Colors.amber[300]!,
              ),
              WeatherDetailCard(
                icon: Icons.nightlight_round,
                title: "Закат",
                value: formatTime(sunsetTime),
                color: Colors.deepPurple[900]!,
              ),
              WeatherDetailCard(
                icon: Icons.thermostat,
                title: "Ощущается",
                value: "${(nowWeather.main!.feelsLike! - 273.15).floor()}°C",
                color: Colors.blue[300]!,
              ),
              WeatherDetailCard(
                icon: Icons.speed,
                title: "Давление",
                value: "${(nowWeather.main!.pressure! * 0.75).floor()} мм",
                color: Colors.green[300]!,
              ),
              WeatherDetailCard(
                icon: Icons.air,
                title: "Ветер",
                value: "${nowWeather.wind!.speed} м/с",
                color: Colors.cyan[300]!,
              ),
              WeatherDetailCard(
                icon: Icons.cloud,
                title: "Облачность",
                value: "${nowWeather.clouds!.all}%",
                color: Colors.grey[300]!,
              ),
              WeatherDetailCard(
                icon: Icons.water_drop,
                title: "Влажность",
                value: "${nowWeather.main!.humidity}%",
                color: Colors.blueAccent[100]!,
              ),
              WeatherDetailCard(
                icon: Icons.visibility,
                title: "Видимость",
                value: "${((nowWeather.visibility! * 0.01).floor() / 10)} км",
                color: Colors.teal[300]!,
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
