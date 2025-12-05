import 'package:http/http.dart' as http;
import 'dart:convert';

final API_KEY = "11c5bb34404731231ac094ed2f7c612f";

Future<Map<String, dynamic>> getNowWeatherData(String city) async {
  Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&lang=ru");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}

Future<Map<String, dynamic>> getDaysWeatherData(String city) async {
  Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${API_KEY}&lang=ru");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Error: ${response.reasonPhrase}");
  }
}
