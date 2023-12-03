import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/all_data_provider.dart';
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
    final allDataAsync = ref.watch(allDataProvider);

    return allDataAsync.when(
      data: (allData) {
        final currentUserId = allData.currentUserID;
        final userPets =
            allData.pets.where((pet) => pet.ownerId == currentUserId).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Schedule'),
          ),
          drawer: CustomDrawer(),
          body: ListView.builder(
            itemCount: userPets.length,
            itemBuilder: (context, index) {
              Pet pet = userPets[index];
              List<String> scheduleItems = pet.schedule;

              // Check if any feeding times are coming up
              bool isFeedingTimeSoon = checkIfFeedingTimeIsSoon(scheduleItems);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealTimeEditScreen(
                        pet: userPets[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: boxColors[index % boxColors.length],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pet: ${pet.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            'Schedule: ${scheduleItems.join(", ")}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8.0),
                          Icon(
                            Icons.access_time,
                            color: isFeedingTimeSoon ? Colors.red : null,
                          ),
                        ],
                      ),
                      if (isFeedingTimeSoon)
                        Text(
                          'Feed me soon!',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (error, st) => Text(error.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }

  bool checkIfFeedingTimeIsSoon(List<String> scheduleItems) {
    DateTime now = DateTime.now();
    //print('Current Time: $now');
    for (String scheduleTime in scheduleItems) {
      DateTime feedingTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(scheduleTime.split(':')[0]),
        int.parse(scheduleTime.split(':')[1]),
      );

      if (feedingTime.isAfter(now) &&
          feedingTime.isBefore(now.add(Duration(minutes: 30)))) {
        return true;
      }
    }

    return false;
  }
}
