import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet_schedule/domain/pet_schedule_db.dart';

final petScheduleDBProvider =
    Provider<PetScheduleDB>((ref) => PetScheduleDB(ref));

final petScheduleNotifierProvider =
    StateNotifierProvider<PetScheduleNotifier, List<PetScheduleData>>((ref) {
  final petScheduleDB = ref.watch(petScheduleDBProvider);
  return PetScheduleNotifier(petScheduleDB.getAllPetSchedules());
});

final currentPetIDProvider = Provider<String>((ref) => 'schedule-001');

final currentPetScheduleProvider = Provider<List<PetScheduleData>>((ref) {
  final petSchedules = ref.watch(petScheduleNotifierProvider);
  final currentPetID = ref.watch(currentPetIDProvider);
  return petSchedules.where((schedule) => schedule.id == currentPetID).toList();
});
