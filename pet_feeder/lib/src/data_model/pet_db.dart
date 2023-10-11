import 'food_item_db.dart';

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
  double weight;
  double age;
  String species;
  String imagePath;
  List<String> schedule;
  FoodItemData foodItemData;
  String? breed;
}

/// Provides access to and operations on all defined users.
class PetDB {
  final List<PetData> _pets = [
    PetData(
        id: 'pet-001',
        name: 'Spot',
        weight: 34.4,
        age: 3.2,
        species: 'Dog',
        imagePath: 'assets/images/dog1.png',
        schedule: ['T20:30:00', 'T08:00:00'],
        foodItemData: FoodItemData(
            petId: 'pet-001',
            username: 'user-001',
            imagePath: 'assets/images/dog_food/dog_food1.jpg'),
        breed: 'Beagle'),
    PetData(
        id: 'pet-002',
        name: 'Mittens',
        weight: 12.4,
        age: 5.2,
        species: 'Cat',
        imagePath: 'assets/images/cat1.png',
        schedule: ['T21:30:00'],
        foodItemData: FoodItemData(
            petId: 'pet-002',
            username: 'user-003',
            imagePath: 'assets/images/dog_food/dog_food1.jpg'),
        breed: 'Beagle'),
    PetData(
      id: 'pet-003',
      name: 'Jeff',
      weight: 34.4,
      age: 3.2,
      species: 'Dog',
      imagePath: 'assets/images/dog2.png',
      schedule: ['T20:30:00', 'T08:00:00'],
      foodItemData: FoodItemData(
          petId: 'pet-003',
          username: 'user-001',
          imagePath: 'assets/images/dog_food/dog_food1.jpg'),
    ),
    PetData(
      id: 'pet-004',
      name: 'Catastrophic',
      weight: 20.4,
      age: 15.2,
      species: 'Cat',
      imagePath: 'assets/images/cat2.png',
      schedule: ['T22:45:00'],
      foodItemData: FoodItemData(
          petId: 'pet-001',
          username: 'user-001',
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
PetDB userDB = PetDB();

/// The currently logged in user.
String currentPetID = 'pet-001';
