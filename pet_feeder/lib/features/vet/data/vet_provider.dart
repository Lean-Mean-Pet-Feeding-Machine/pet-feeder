import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/vet_db.dart';

final vetDBProvider = Provider<VetDB>((ref) {
  return VetDB(ref);
});
