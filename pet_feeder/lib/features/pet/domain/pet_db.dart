import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../food_item/domain/food_item_db.dart';

/// The data associated with users.

class PetData {
  PetData(
      {required this.id,
      required this.name,
      required this.weight,
      required this.age,
      required this.species,
      required this.imagePath,
      required this.schedule,
      required this.foodItemData,
      this.breed});

  String id;
  String name;
  List<(double, DateTime)> weight;
  DateTime age;
  String species;
  String imagePath;
  List<String> schedule;
  FoodItemData foodItemData;
  String? breed;
}

/// Provides access to and operations on all defined users.
class PetDB {
  PetDB(this.ref);
  final ProviderRef<PetDB> ref;

  final List<PetData> _pets = [
    PetData(
        id: 'pet-001',
        name: 'Spot',
        weight: [(34.4, DateTime(2022, 10, 22)), (24.4, DateTime(2022, 11, 22)), (34.4, DateTime(2022, 12, 22))],
        age: DateTime(2021, 2, 12),
        species: 'Dog',
        imagePath: 'assets/images/dog1.png',
        schedule: ['20:30', '08:00'],
        foodItemData: FoodItemData(
            petId: 'pet-001',
            userId: 'user-001',
            imagePath: 'assets/images/dog_food/dog_food1.jpg'),
        breed: 'Beagle'),
    PetData(
        id: 'pet-002',
        name: 'Mittens',
        weight: [(12.4, DateTime(2022, 10, 23))],
        age: DateTime(2018, 8, 13),
        species: 'Cat',
        imagePath: 'assets/images/cat1.png',
        schedule: ['21:30'],
        foodItemData: FoodItemData(
            petId: 'pet-002',
            userId: 'user-003',
            imagePath: 'assets/images/dog_food/dog_food1.jpg'),
        breed: 'Beagle'),
    PetData(
      id: 'pet-003',
      name: 'Jeff',
      weight: [(34.4, DateTime(2022, 10, 23))],
      age: DateTime(2000, 12, 15),
      species: 'Dog',
      imagePath: 'assets/images/dog2.png',
      schedule: ['20:30', '08:00'],
      foodItemData: FoodItemData(
          petId: 'pet-003',
          userId: 'user-001',
          imagePath: 'assets/images/dog_food/dog_food1.jpg'),
    ),
    PetData(
      id: 'pet-004',
      name: 'Catastrophic',
      weight: [(20.4, DateTime(2022, 10, 23))],
      age: DateTime(2010, 9, 8),
      species: 'Cat',
      imagePath: 'assets/images/cat2.png',
      schedule: ['22:45'],
      foodItemData: FoodItemData(
          petId: 'pet-001',
          userId: 'user-001',
          imagePath: 'assets/images/dog_food/dog_food1.jpg'),
    ),
  ];

  PetData getPet(String petId) {
    return _pets.firstWhere((petData) => petData.id == petId);
  }

  List<PetData> getPets(userIDs) {
    return _pets.where((userData) => userIDs.contains(userData.id)).toList();
  }
}

/// The singleton instance providing access to all user data for clients.

/// The currently logged in user.
String currentPetID = 'pet-001';

