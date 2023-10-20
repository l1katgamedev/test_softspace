import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_softspace/screens/calculator.dart';
import 'package:test_softspace/screens/weather.dart';

import '../bloc/weather_bloc.dart';
import 'inputs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.input_outlined),
              ),
              Tab(
                icon: Icon(Icons.calculate_outlined),
              ),
              Tab(
                icon: Icon(Icons.sunny),
              ),
            ],
          ),
          title: const Text('Soft Space Test'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const TabBarView(
            children: [
              InputsScreen(),
              CalculatorScreen(),
              WeatherScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
