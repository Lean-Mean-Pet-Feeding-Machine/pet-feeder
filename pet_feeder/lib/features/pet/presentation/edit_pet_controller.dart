import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/pet_database.dart';
import '../data/pet_provider.dart';
import '../domain/pet.dart';

part 'edit_pet_controller.g.dart';

// The design of this controller is modeled on:
// https://codewithandrea.com/articles/flutter-navigate-without-context-gorouter-riverpod/
// https://codewithandrea.com/articles/async-notifier-mounted-riverpod/
// I am not in love with the "mounted" shenanigans. Sigh.
@riverpod
class EditPetController extends _$EditPetController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
    state = const AsyncData(null);
  }

  // Invoked to add a new pet or edit an existing one.
  Future<void> updatePet({
    required Pet pet,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    PetDatabase petDatabase = ref.watch(petDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => petDatabase.setPetData(pet));
    if (mounted) {
      state = newState;
    }
    // Weird. Can't use "if (state.hasValue)" below.
    if (!state.hasError) {
      onSuccess();
    }
  }

  Future<void> deletePet({
    required Pet pet,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncLoading();
    PetDatabase petDatabase = ref.watch(petDatabaseProvider);
    final newState =
        await AsyncValue.guard(() => petDatabase.deletePetData(pet));
    if (mounted) {
      state = newState;
    }
    if (!state.hasError) {
      onSuccess();
    }
  }
}
