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
  // Add more fields if necessary
}

/// Provides access to and operations on pet schedule data.
class PetScheduleDB {
  final List<PetScheduleData> _petSchedules = [
    PetScheduleData(
      id: 'schedule-001',
      petName: 'Buddy',
      schedule: ['T21:30:00'],
    ),
    PetScheduleData(
      id: 'schedule-002',
      petName: 'Whiskers',
      schedule: ['T8:30:00', 'T20:30:00'],
    ),
    PetScheduleData(
      id: 'schedule-002',
      petName: 'Doodle',
      schedule: ['T6:00:00', 'T20:00:00'],
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
}

/// The singleton instance providing access to all pet schedule data for clients.
PetScheduleDB petScheduleDB = PetScheduleDB();
