import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet_schedule/domain/pet_schedule_db.dart';

final petScheduleDBProvider = Provider<PetScheduleDB>((ref) => PetScheduleDB(ref));
