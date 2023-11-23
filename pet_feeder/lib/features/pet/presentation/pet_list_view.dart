import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/all_data_provider.dart';
import 'package:pet_feeder/features/loading/loading.dart';
import 'package:pet_feeder/features/pet/data/pet_provider.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/user/data/user_providers.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import 'package:provider/provider.dart';
import '../../user/domain/user.dart';
import '../domain/pet_db.dart';
import 'pet_info.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'package:pet_feeder/features/common/theme.dart';
import 'package:pet_feeder/features/common/thememode.dart';

class PetListPage extends ConsumerWidget {
  final UserData? currentUser;

  const PetListPage({Key? key, required this.currentUser}) : super(key: key);

  static const String routeName = '/petList';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) => _build(
        context: context,
        pets: allData.pets
            .where((pet) => pet.ownerId == allData.currentUserID)
            .toList(),
        uid: allData.currentUserID,
        user: allData.currentUser,
        ref: ref,
      ),
      error: (error, st) => Text(error.toString()),
      loading: () => const Loading(),
    );
  }

  Widget _build({
    required BuildContext context,
    required List<Pet> pets,
    required String? uid,
    required User? user,
    required WidgetRef ref,
  }) {
    return Theme(
      data: ThemeModeOption.light == ThemeModeOption.light
          ? lightTheme
          : darkTheme, // Apply appropriate theme based on the currentThemeMode
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pet List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            print(uid)
          },
          child: Icon(Icons.add),

        ),
        drawer: CustomDrawer(),
        body: ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, index) {
            final pet = pets[index];
            print(pet.toString());
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(pet.imagePath),
                radius: 25,
              ),
              title: Text(pet.name),
              onTap: () {
                navigateToDetails(context, pet);
              },
            );
          },
        ),
      ),
    );
  }

  void navigateToDetails(BuildContext context, Pet pet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetInfo(pet: pet), // Pass the pet data directly
      ),
    );
  }
}
// ElevatedButton(
//             onpressed: () => {
//               ref.watch(petdatabaseprovider).setpetdata(pet(
//                 id: 'pet-004',
//                 ownerid: uid!,
//                 name: 'jeff',
//                 weight: [],
//                 when: [],
//                 age: "2023-11-19t12:00:00z",
//                 species: 'dog',
//                 imagepath: 'assets/images/dog4.png',
//                 schedule: [],
//               ))
//             },
//             child: text('hello')),