import 'package:flutter/material.dart';

class WeatherUtils {
  static String getWeatherEmoji(String weatherType) {
    switch (weatherType.toLowerCase()) {
      case 'clear': return '☀️';
      case 'clouds': return '☁️';
      case 'rain': return '🌧️';
      case 'drizzle': return '🌦️';
      case 'thunderstorm': return '⛈️';
      case 'snow': return '❄️';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return '🌫️';
      default: return '🌈';
    }
  }

  static String formatDateTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:00";
  }

  static Map<String, List<T>> groupWeatherByDay<T>(
      List<T> weatherList,
      int Function(T) getTimestamp,
      ) {
    final Map<String, List<T>> grouped = {};

    for (var weather in weatherList) {
      final date = DateTime.fromMillisecondsSinceEpoch(getTimestamp(weather) * 1000);
      final dayKey = "${date.year}-${date.month}-${date.day}";

      if (!grouped.containsKey(dayKey)) {
        grouped[dayKey] = [];
      }
      grouped[dayKey]!.add(weather);
    }

    return grouped;
  }

  static Color getTemperatureColor(double temp) {
    final celsius = temp - 273.15;
    if (celsius > 30) return Colors.red.shade400;
    if (celsius > 20) return Colors.orange.shade400;
    if (celsius > 10) return Colors.yellow.shade600;
    if (celsius > 0) return Colors.blue.shade300;
    return Colors.blue.shade700;
  }

  static String formatDate(DateTime time) {
    return "${time.day.toString().padLeft(2, '0')}.${time.month.toString().padLeft(2, '0')}";
  }

  static String getDayLabel(DateTime time) {
    return time.day == DateTime.now().day ? "Сегодня" : formatDate(time);
  }
}
