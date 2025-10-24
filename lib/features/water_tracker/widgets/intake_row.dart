import 'package:flutter/material.dart';
import 'package:prac6/features/water_tracker/models/water_intake.dart';
import 'package:prac6/shared/constants/drink_types.dart';

class IntakeRow extends StatelessWidget {
  final WaterIntake intake;
  final ValueChanged<String> onDelete;

  const IntakeRow({
    super.key,
    required this.intake,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final drink = DrinkTypes.allTypes.firstWhere(
          (d) => d.id == intake.drinkType,
      orElse: () => DrinkTypes.allTypes.first,
    );

    return ListTile(
      leading: Icon(
        drink.icon,
        color: drink.color,
      ),
      title: Text('${intake.volume} мл'),
      subtitle: Text(
        '${_formatTime(intake.time)} • ${drink.name}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => onDelete(intake.id),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

