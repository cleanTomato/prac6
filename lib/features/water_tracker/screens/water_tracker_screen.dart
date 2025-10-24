import 'package:flutter/material.dart';
import 'package:prac6/features/water_tracker/models/water_intake.dart';
import 'package:prac6/features/water_tracker/widgets/intake_list_view.dart';
import 'package:prac6/features/water_tracker/widgets/smart_water_button.dart';
import 'package:prac6/features/water_tracker/widgets/water_level_indicator.dart';
import 'package:prac6/shared/widgets/progress_circle.dart';
import 'package:prac6/shared/constants/app_constants.dart';
import 'package:prac6/features/water_tracker/screens/network_images_screen.dart';

class WaterTrackerScreen extends StatelessWidget {
  final List<WaterIntake> intakes;
  final int dailyGoal;
  final VoidCallback onAdd;
  final ValueChanged<String> onDelete;
  final ValueChanged<int> onGoalChange;

  const WaterTrackerScreen({
    super.key,
    required this.intakes,
    required this.dailyGoal,
    required this.onAdd,
    required this.onDelete,
    required this.onGoalChange,
  });

  @override
  Widget build(BuildContext context) {
    final totalIntake = intakes.fold(0, (sum, intake) => sum + intake.effectiveVolume);
    final progress = dailyGoal > 0 ? totalIntake / dailyGoal : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Водный баланс'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NetworkImagesScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showGoalDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProgressCircle(
                  progress: progress.toDouble(),
                  current: totalIntake,
                  goal: dailyGoal,
                ),
                WaterLevelIndicator(progress: progress.toDouble()),
              ],
            ),
            const SizedBox(height: 20),
            SmartWaterButton(
              currentVolume: totalIntake,
              dailyGoal: dailyGoal,
              onPressed: onAdd,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: IntakeListView(
                intakes: intakes,
                onDelete: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGoalDialog(BuildContext context) {
    final controller = TextEditingController(text: dailyGoal.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Дневная цель'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Объем в мл',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newGoal = int.tryParse(controller.text) ?? AppConstants.defaultDailyGoal;
                onGoalChange(newGoal);
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}