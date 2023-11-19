import 'dart:async';

import 'package:pet_feeder/features/pet/data/pet_provider.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/user/data/user_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user/domain/user.dart';

part 'all_data_provider.g.dart';

class AllData {
  AllData(
      {
        required this.pets,
        required this.users,
        // required this.currentUserID
      });

  final List<Pet> pets;
  final List<User> users;
  // final String currentUserID;
}

@riverpod
Future<AllData> allData(AllDataRef ref) async {
  final pets = ref.watch(petsProvider.future);
  final users = ref.watch(usersProvider.future);
  // final currentUserID = ref.watch(currentUserIDProvider);
  return AllData(
      pets: await pets,
      users: await users,
      // currentUserID: currentUserID,
      );
}
