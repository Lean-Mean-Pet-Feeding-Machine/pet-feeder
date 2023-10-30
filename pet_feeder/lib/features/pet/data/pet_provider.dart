import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/pet/domain/pet_db.dart';

final petDBProvider = Provider<PetDB>((ref) => PetDB(ref));
