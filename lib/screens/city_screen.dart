import 'package:flutter/material.dart';
import 'package:lab6/screens/cubit/city_weather_cubit.dart';
import 'package:lab6/screens/cubit/city_weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cityNameField = TextEditingController();
  bool _isError = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Выберите город",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade400,
      ),
      body: _Body(),
    );
  }

  Widget _Body() {
    return BlocBuilder<CityWeatherCubit, CityWeatherState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsetsGeometry.only(top: 30, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Название города",
                    labelStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  controller: _cityNameField,
                  validator: (value) {
                    if(value!.isEmpty) return "Введите название города";
                    return null;
                  },
                ),
                SizedBox(height: 10),
                if (_isLoading) Center(child: CircularProgressIndicator(color: Colors.blue.shade400)),
                if (_isError) Center(child: Text("Такого города не найдено", style: TextStyle(color: Colors.redAccent))),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (!_isLoading) {
                      setState(() {
                        _isError = false;
                        _isLoading = true;
                      });

                      bool isSuccess = await BlocProvider.of<CityWeatherCubit>(context).changeCity(_cityNameField.text);

                      if (isSuccess) Navigator.of(context).pop();

                      setState(() {
                        _isError = !isSuccess;
                        _isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.blue.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
        );
      },
    );
  }
}
