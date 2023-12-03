import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/pet/data/pet_provider.dart';

class MealTimeEditScreen extends ConsumerWidget {
  final Pet pet;

  MealTimeEditScreen({required this.pet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealTimeController = TextEditingController();
    mealTimeController.text = pet.schedule.join(', ');

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Meal Time for ${pet.name}'),
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
              onPressed: () async {
                String newMealTime = mealTimeController.text;

                Pet updatedPet = pet.copyWith(
                  schedule:
                      newMealTime.split(',').map((e) => e.trim()).toList(),
                );
                // Update the meal time
                await ref
                    .read(petDatabaseProvider)
                    .setPetDataDelayed(updatedPet);

                await Future.delayed(Duration(milliseconds: 700));

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
