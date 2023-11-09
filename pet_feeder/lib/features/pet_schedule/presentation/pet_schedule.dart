import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet_schedule/data/pet_schedule_provider.dart';
import '../domain/pet_schedule_db.dart';
import 'meal_time_edit_screen.dart';

class SchedulePage extends ConsumerWidget {
  final List<Color> boxColors = [
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.orange[100]!,
    Colors.pink[100]!,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPetSchedule = ref.watch(currentPetScheduleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: currentPetSchedule.length,
        itemBuilder: (context, index) {
          PetScheduleData petSchedule = currentPetSchedule[index];
          List<String> petNames = petSchedule.pets;
          List<String> scheduleItems = petSchedule.schedule;

          return Column(
            children: [
              SizedBox(height: 8.0),
              for (int i = 0; i < petNames.length; i++)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealTimeEditScreen(
                          petSchedule: petSchedule,
                          petIndex: i, // Pass the index of the selected pet
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: boxColors[i % boxColors.length],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pet: ${petNames[i]}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              'Meal Times: ${scheduleItems[i]}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.access_time),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
