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
      appBar: AppBar(
        title: Text(
          "${dayName}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade400,
      ),
      body: _Body(),
    );
  }

  Widget _Body() {
    return Container(
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
        ),
        StatItem(
          icon: Icons.water_drop,
          value: "${hourlyForecasts.first.main!.humidity}%",
          label: "Влажность",
        ),
        StatItem(
          icon: Icons.air,
          value: "${hourlyForecasts.first.wind?.speed?.toStringAsFixed(1) ?? '0'} м/с",
          label: "Ветер",
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
