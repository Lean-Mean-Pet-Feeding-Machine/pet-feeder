import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet_schedule/data/pet_schedule_provider.dart';
import '../domain/pet_schedule_db.dart';

class MealTimeEditScreen extends ConsumerWidget {
  final PetScheduleData petSchedule;
  final int petIndex;

  MealTimeEditScreen({required this.petSchedule, required this.petIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealTimeController = TextEditingController();

    // Set initial text in the TextFormField to the current meal time
    mealTimeController.text = petSchedule.schedule[petIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Meal Time for ${petSchedule.pets[petIndex]}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: mealTimeController,
              decoration: InputDecoration(labelText: 'Enter Meal Time'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String newMealTime = mealTimeController.text;
                // Update the specific meal time using petIndex
                petSchedule.schedule[petIndex] = newMealTime;
                // Update the meal times in the provider
                ref
                    .read(petScheduleNotifierProvider.notifier)
                    .updateMealTimes(petSchedule.id, petSchedule.schedule);
                Navigator.pop(context); // Close the editing screen after saving
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
