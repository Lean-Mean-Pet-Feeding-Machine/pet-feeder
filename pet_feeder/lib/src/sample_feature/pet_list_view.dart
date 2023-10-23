import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_model/pet_db.dart';
import 'pet_info.dart';
import 'package:pet_feeder/src/sample_feature/side_menu.dart';

class PetListPage extends ConsumerWidget {
  static const String routeName = '/petList';

  // List of pet IDs to display
  final List<String> petIDs = ['pet-001', 'pet-002', 'pet-003', 'pet-004'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petDB = ref.watch(petDBProvider);
    List<PetData> pets = petDB.getPets(petIDs);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet List'),
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(pet
                  .imagePath), // Assuming imagePath is the path to the pet's icon
              radius: 25,
            ),
            title: Text(pet.name),
            onTap: () {
              navigateToDetails(context, pet);
            },
          );
        },
      ),
    );
  }

  void navigateToDetails(BuildContext context, PetData pet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetInfo(pet: pet), // Pass the pet data directly
      ),
    );
  }
}
