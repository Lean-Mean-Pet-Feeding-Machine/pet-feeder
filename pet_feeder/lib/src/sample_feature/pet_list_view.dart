import 'package:flutter/material.dart';
import 'sample_item_details_view.dart';

class Pet {
  final int id;
  final String name;
  final String iconAsset;

  Pet(this.id, this.name, this.iconAsset);
}

class PetListPage extends StatefulWidget {
  static const String routeName = '/petList';

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  List<Pet> pets = [
    Pet(1, 'Pet 1', 'assets/images/dog1.png'),
    Pet(2, 'Pet 2', 'assets/images/dog2.png'),
    Pet(3, 'Pet 3', 'assets/images/dog3.png'),
  ];

  void addPet() {
    final newId = pets.length + 1;
    final newName = 'Pet $newId';
    final newIconAsset = 'assets/images/flutter_logo.png';

    setState(() {
      pets.add(Pet(newId, newName, newIconAsset));
    });
  }

  void navigateToDetails(BuildContext context, Pet pet) {
    Navigator.pushNamed(
      context,
      SampleItemDetailsView.routeName,
      arguments: pet,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet List'),
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(pet.iconAsset),
              radius: 25, // Adjust the radius as needed
            ),
            title: Text(pet.name),
            onTap: () {
              navigateToDetails(context, pet);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPet();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
