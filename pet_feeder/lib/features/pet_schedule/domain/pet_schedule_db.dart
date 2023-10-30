import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with pet schedules.
class PetScheduleData {
  PetScheduleData({
    required this.id,
    required this.petName,
    required this.schedule,
  });

  String id;
  String petName;
  List<String> schedule;
}

/// Provides access to and operations on pet schedule data.
class PetScheduleDB {
  PetScheduleDB(this.ref);
  final ProviderRef<PetScheduleDB> ref;

  final List<PetScheduleData> _petSchedules = [
    PetScheduleData(
      id: 'schedule-001',
      petName: 'Spot',
      schedule: ['T08:30', 'T20:00'],
    ),
    PetScheduleData(
      id: 'schedule-002',
      petName: 'Mittens',
      schedule: ['T21:30'],
    ),
    PetScheduleData(
      id: 'schedule-003',
      petName: 'Jeff',
      schedule: ['T08:30', 'T20:30'],
    ),
    PetScheduleData(
      id: 'schedule-004',
      petName: 'Catastrophic',
      schedule: ['T06:00', 'T20:00'],
    ),
  ];

  PetScheduleData getPetSchedule(String scheduleID) {
    return _petSchedules
        .firstWhere((scheduleData) => scheduleData.id == scheduleID);
  }

  List<PetScheduleData> getPetSchedulesByPetName(String petName) {
    return _petSchedules
        .where((scheduleData) => scheduleData.petName == petName)
        .toList();
  }

  List<PetScheduleData> getAllPetSchedules() {
    return _petSchedules;
  }
}

String currentPetID = 'schedule-001';
