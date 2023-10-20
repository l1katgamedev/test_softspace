import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_softspace/bloc/weather_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    locationController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }


  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/8.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white60,
        ),
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<WeatherBloc, WeatherBlocState>(
          builder: (context, state) {
            if (state is WeatherBlocSuccess) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: "Введите локацию",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                        onFieldSubmitted: (String cityName) {
                          BlocProvider.of<WeatherBloc>(context).add(FetchWeather(locationController.text));

                          locationController.text = '';
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 200,
                      child: getWeatherIcon(state.weather.weatherConditionCode!),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      '${state.weather.areaName}',
                      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 38),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${state.weather.temperature!.celsius!.round()}°C',
                        style: const TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: Text(
                        state.weather.weatherMain!.toUpperCase(),
                        style: const TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        DateFormat('EEEE dd |').add_jm().format(state.weather.date!),
                        style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is WeatherBlocFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Что-то пошло не так',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<WeatherBloc>(context).add(FetchWeather('Tashkent'));
                      },
                      child: const Text('Попробуйте снова'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
