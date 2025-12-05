import 'package:flutter/material.dart';
import 'package:lab6/models/weather_list.dart';
import 'package:lab6/screens/detail_page.dart';

class ForecastCard extends StatelessWidget {
  final List<WeatherList> forecasts;
  final String dayKey;
  final int minTempC;
  final int maxTempC;
  final String weatherEmoji;

  const ForecastCard({
    Key? key,
    required this.forecasts,
    required this.dayKey,
    required this.minTempC,
    required this.maxTempC,
    required this.weatherEmoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstForecastTime = DateTime.fromMillisecondsSinceEpoch(
      forecasts.first.dt! * 1000,
    );

    final fullDayName = _getFullWeekday(firstForecastTime.weekday);
    final description = forecasts.first.weather![0].description!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              hourlyForecasts: forecasts,
              dayName: fullDayName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xFFF5F7FA),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // День недели и дата
              Container(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getShortWeekday(firstForecastTime.weekday),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${firstForecastTime.day.toString().padLeft(2, '0')}.${firstForecastTime.month.toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Эмодзи погоды
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    weatherEmoji,
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),

              SizedBox(width: 16),

              // Описание и температура
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.thermostat,
                          size: 14,
                          color: Colors.orange[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          "$maxTempC° / $minTempC°",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Стрелка
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.blue[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFullWeekday(int weekday) {
    switch (weekday) {
      case 1: return "Понедельник";
      case 2: return "Вторник";
      case 3: return "Среда";
      case 4: return "Четверг";
      case 5: return "Пятница";
      case 6: return "Суббота";
      case 7: return "Воскресенье";
      default: return "";
    }
  }

  String _getShortWeekday(int weekday) {
    switch (weekday) {
      case 1: return "Пн";
      case 2: return "Вт";
      case 3: return "Ср";
      case 4: return "Чт";
      case 5: return "Пт";
      case 6: return "Сб";
      case 7: return "Вс";
      default: return "";
    }
  }
}
