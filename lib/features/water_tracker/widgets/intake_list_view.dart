import 'package:flutter/material.dart';
import 'package:prac6/features/water_tracker/models/water_intake.dart';
import 'package:prac6/features/water_tracker/widgets/intake_row.dart';
import 'package:prac6/shared/widgets/empty_state.dart';

class IntakeListView extends StatelessWidget {
  final List<WaterIntake> intakes;
  final ValueChanged<String> onDelete;

  const IntakeListView({
    super.key,
    required this.intakes,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (intakes.isEmpty) {
      return const EmptyState(
        message: 'Вы еще не добавили\nни одной записи',
        icon: Icons.water_drop_outlined,
      );
    }

    return ListView.builder(
      itemCount: intakes.length,
      itemBuilder: (context, index) {
        final intake = intakes[index];
        return IntakeRow(
          intake: intake,
          onDelete: onDelete,
        );
      },
    );
  }
}

