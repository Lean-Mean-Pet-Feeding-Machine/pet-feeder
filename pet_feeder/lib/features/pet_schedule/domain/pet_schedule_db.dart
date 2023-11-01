import 'package:flutter_riverpod/flutter_riverpod.dart';

class PetScheduleNotifier extends StateNotifier<List<PetScheduleData>> {
  PetScheduleNotifier(List<PetScheduleData> initialPetSchedules)
      : super(initialPetSchedules);

  void updateMealTimes(String scheduleID, List<String> newMealTimes) {
    state = state.map((schedule) {
      if (schedule.id == scheduleID) {
        // Provide the pets parameter when calling copyWith
        return schedule.copyWith(pets: schedule.pets, schedule: newMealTimes);
      } else {
        return schedule;
      }
    }).toList();
  }
}

class PetScheduleData {
  PetScheduleData({
    required this.id,
    required this.pets,
    required this.schedule,
  });

  String id;
  List<String> pets;
  List<String> schedule;

  PetScheduleData copyWith({
    required List<String> pets,
    required List<String> schedule,
  }) {
    return PetScheduleData(
      id: id,
      pets: pets,
      schedule: schedule,
    );
  }
}

class PetScheduleDB {
  PetScheduleDB(this.ref);
  final ProviderRef<PetScheduleDB> ref;

  final List<PetScheduleData> _petSchedules = [
    //TODO: Each PetScheduleData should belong to a specific user
    PetScheduleData(
      id: 'schedule-001',
      pets: ['Spot', 'Catastrophic', 'Mittens', 'Jeff'],
      schedule: [
        'T08:30, T20:00',
        'T06:30, T20:00',
        'T21:30',
        'T08:30, T20:00'
      ],
    ),
    PetScheduleData(
      id: 'schedule-002',
      pets: ['Cloudy', 'Fluffy'],
      schedule: ['T08:30, T20:00', 'T06:30, T20:00'],
    ),
  ];

  PetScheduleData getPetSchedule(String scheduleID) {
    return _petSchedules
        .firstWhere((scheduleData) => scheduleData.id == scheduleID);
  }

  List<PetScheduleData> getPetSchedulesByPetName(String petName) {
    return _petSchedules
        .where((scheduleData) => scheduleData.pets.contains(petName))
        .toList();
  }

  List<PetScheduleData> getAllPetSchedules() {
    return _petSchedules;
  }
}

String currentPetID = 'schedule-001';
