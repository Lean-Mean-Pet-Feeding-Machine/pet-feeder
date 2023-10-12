import 'package:flutter/material.dart';
import 'src/data_model/schedule_db.dart';

class SchedulePage extends StatelessWidget {
  final PetScheduleDB petScheduleDB = PetScheduleDB();
  final List<Color> boxColors = [
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.orange[100]!,
    Colors.pink[100]!,
  ];

  @override
  Widget build(BuildContext context) {
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
