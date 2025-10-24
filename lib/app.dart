import 'package:flutter/material.dart';
import 'package:prac6/features/water_tracker/state/water_tracker_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер водного баланса',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WaterTrackerContainer(),
    );
  }
}