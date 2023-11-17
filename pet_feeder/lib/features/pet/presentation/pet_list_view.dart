import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/all_data_provider.dart';
import 'package:pet_feeder/features/loading/loading.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import '../domain/pet_db.dart';
import 'pet_info.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'package:pet_feeder/features/common/theme.dart';
import 'package:pet_feeder/features/common/thememode.dart';

class PetListPage extends ConsumerWidget {
  final UserData? currentUser;

  PetListPage({Key? key, required this.currentUser}) : super(key: key);

  static const String routeName = '/petList';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<AllData> asyncAllData = ref.watch(allDataProvider);
    return asyncAllData.when(
      data: (allData) =>
          _build(
            context: context,
            pets: allData.pets,
          ),
      error: (error, st) => Text("hello"),
      loading: () => const Loading(),
    );
  }

  Widget _build({
    required BuildContext context,
    required List<Pet> pets,
}) {
    return Theme(
      data: ThemeModeOption.light == ThemeModeOption.light
          ? lightTheme
          : darkTheme, // Apply appropriate theme based on the currentThemeMode
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pet List'),
        ),
        drawer: CustomDrawer(
          currentUser: currentUser,
        ),
        body: ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, index) {
            final pet = pets[index];
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
