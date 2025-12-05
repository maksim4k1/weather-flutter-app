import 'package:flutter/material.dart';
import 'package:lab6/models/weather_list.dart';
import 'package:lab6/screens/widgets/weather_stat_card.dart';
import 'package:lab6/screens/widgets/weather_detail_item.dart';
import 'package:lab6/screens/widgets/weather_list_container.dart';

class DetailPage extends StatelessWidget {
  final List<WeatherList> hourlyForecasts;
  final String dayName;

  const DetailPage({
    required this.hourlyForecasts,
    required this.dayName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }

  AppBar _AppBar() {
    return AppBar(
      title: Text(
        "${dayName}",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade700,
              Colors.lightBlue.shade400,
            ],
          ),
        ),
      ),
    );
  }

  Widget _Body() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.lightBlue.shade50,
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildWeatherStats(),
          _buildForecastList(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildWeatherStats() {
    return WeatherStatCard(
      statItems: [
        StatItem(
          icon: Icons.thermostat,
          value: "${(hourlyForecasts.first.main!.temp! - 273.15).floor()}°",
          label: "Температура",
          color: Colors.white,
        ),
        StatItem(
          icon: Icons.water_drop,
          value: "${hourlyForecasts.first.main!.humidity}%",
          label: "Влажность",
          color: Colors.white,
        ),
        StatItem(
          icon: Icons.air,
          value: "${hourlyForecasts.first.wind?.speed?.toStringAsFixed(1) ?? '0'} м/с",
          label: "Ветер",
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildForecastList() {
    return Expanded(
      child: WeatherListContainer(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: hourlyForecasts.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Colors.grey.shade200,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, index) {
            return WeatherDetailItem(
              forecast: hourlyForecasts[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}
