import 'package:flutter/material.dart';
import 'package:lab6/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab6/screens/cubit/city_weather_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CityWeatherCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
