import 'package:flutter/material.dart';
import 'package:prac6/features/water_tracker/models/water_intake.dart';
import 'package:prac6/features/water_tracker/screens/water_tracker_screen.dart';
import 'package:prac6/features/water_tracker/screens/add_intake_screen.dart';
import 'package:prac6/shared/constants/app_constants.dart';

enum Screen { tracker, addIntake }

class WaterTrackerContainer extends StatefulWidget {
  const WaterTrackerContainer({super.key});

  @override
  State<WaterTrackerContainer> createState() => _WaterTrackerContainerState();
}

class _WaterTrackerContainerState extends State<WaterTrackerContainer> {
  final List<WaterIntake> _intakes = [];
  int _dailyGoal = AppConstants.defaultDailyGoal;
  Screen _currentScreen = Screen.tracker;

  void _addIntake(int volume, String drinkType) {
    setState(() {
      final newIntake = WaterIntake(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        volume: volume,
        drinkType: drinkType,
        time: DateTime.now(),
      );
      _intakes.add(newIntake);
      _currentScreen = Screen.tracker;
    });
  }

  void _deleteIntake(String id) {
    setState(() {
      _intakes.removeWhere((intake) => intake.id == id);
    });
  }

  void _updateDailyGoal(int newGoal) {
    setState(() {
      _dailyGoal = newGoal;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case Screen.tracker:
        return WaterTrackerScreen(
          intakes: _intakes,
          dailyGoal: _dailyGoal,
          onAdd: () => setState(() => _currentScreen = Screen.addIntake),
          onDelete: _deleteIntake,
          onGoalChange: _updateDailyGoal,
        );


      case Screen.addIntake:
        return AddIntakeScreen(
          onSave: _addIntake,
          onCancel: () => setState(() => _currentScreen = Screen.tracker),
        );
    }
  }
}

