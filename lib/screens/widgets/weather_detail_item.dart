// lib/widgets/weather_detail_item.dart
import 'package:flutter/material.dart';
import 'package:lab6/models/weather_list.dart';
import 'package:lab6/utils/weather_utils.dart';

class WeatherDetailItem extends StatelessWidget {
  final WeatherList forecast;
  final int index;

  const WeatherDetailItem({
    Key? key,
    required this.forecast,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateTime.fromMillisecondsSinceEpoch(forecast.dt! * 1000);
    final temp = forecast.main!.temp! - 273.15;
    final weatherType = forecast.weather![0].main!;
    final weatherDesc = forecast.weather![0].description!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: index.isEven ? Colors.white : Colors.grey.shade50,
      child: Row(
        children: [
          // Время
          _buildTimeSection(time),

          // Иконка погоды
          _buildWeatherIcon(weatherType),

          // Температура
          _buildTemperatureBadge(temp),

          // Описание и детали
          _buildWeatherDetails(weatherDesc, forecast),
        ],
      ),
    );
  }

  Widget _buildTimeSection(DateTime time) {
    return Container(
      width: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            WeatherUtils.formatDateTime(time),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            WeatherUtils.getDayLabel(time),
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(String weatherType) {
    return Container(
      width: 50,
      alignment: Alignment.center,
      child: Text(
        WeatherUtils.getWeatherEmoji(weatherType),
        style: TextStyle(fontSize: 28),
      ),
    );
  }

  Widget _buildTemperatureBadge(double temp) {
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: WeatherUtils.getTemperatureColor(temp + 273.15),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: WeatherUtils.getTemperatureColor(temp + 273.15).withOpacity(0.4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Text(
              "${temp.floor()}°",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(String description, WeatherList forecast) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          _buildWeatherParameters(forecast),
        ],
      ),
    );
  }

  Widget _buildWeatherParameters(WeatherList forecast) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        _buildParameterItem(
          icon: Icons.water_drop,
          value: "${forecast.main!.humidity}%",
        ),
        _buildParameterItem(
          icon: Icons.air,
          value: "${forecast.wind?.speed?.toStringAsFixed(1) ?? '0'} м/с",
        ),
        if (forecast.main!.pressure != null)
          _buildParameterItem(
            icon: Icons.compress,
            value: "${forecast.main!.pressure} hPa",
          ),
      ],
    );
  }

  Widget _buildParameterItem({
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey.shade600,
          ),
          SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
