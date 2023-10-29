import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet_schedule/data/pet_schedule_provider.dart';
import '../domain/pet_schedule_db.dart';

class SchedulePage extends ConsumerWidget {
  final List<Color> boxColors = [
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.orange[100]!,
    Colors.pink[100]!,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petScheduleDB = ref.watch(petScheduleDBProvider);
    List<PetScheduleData> petSchedules = petScheduleDB.getAllPetSchedules();

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: ListView.builder(
        itemCount: petSchedules.length,
        itemBuilder: (context, index) {
          PetScheduleData petSchedule = petSchedules[index];
          List<String> scheduleItems = petSchedule.schedule;

          return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: boxColors[index % boxColors.length], // loop through colors
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pet: ${petSchedule.petName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Meal Times: ${scheduleItems.join(", ")}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
