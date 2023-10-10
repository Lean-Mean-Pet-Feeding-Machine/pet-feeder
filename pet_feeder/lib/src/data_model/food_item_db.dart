import 'dart:math';

/// The data associated with users.

class FoodItemData {
  FoodItemData({
    required this.petId,
    required this.username,
    required this.imagePath,
    this.zipcode,
  }) {
   nutrients = generateMap();
  }

  String petId;
  String username;
  String imagePath;
  Map<String, double>? nutrients;
  String? zipcode;


  Map<String, double> generateMap() {
    var rng = Random();
    final Map<String, double> map = {
      'Calorie': rng.nextDouble() * 200,
      'Protein': rng.nextDouble() * 10,
      'Minerals': rng.nextDouble() * 5,
      'Vitamins': rng.nextDouble() * 4,
    };
    return map;
  }

}

/// Provides access to and operations on all defined users.
class FoodItemDB {


  final List<FoodItemData> _foodItems = [
    FoodItemData(
      petId: 'pet-001',
      username: 'Jeff Robber',
      imagePath: 'assets/images/dog_food/dog_food1.jpg',
      zipcode: '96838',
    ),
    FoodItemData(
      petId: 'pet-002',
      username: 'Lisa Rental',
      imagePath: 'assets/images/dog_food/dog_food1.jpg',
      zipcode: '96789',
    ),
    FoodItemData(
      petId: 'pet-003',
      username: 'Justin Case',
      imagePath: 'assets/images/dog_food/dog_food2.jpg',
      zipcode: '96850',
    ),
    FoodItemData(
      petId: 'pet-004',
      username: 'Clara Voyant',
      imagePath: 'assets/images/dog_food/dog_food3.jpg',
      zipcode: '96081',
    ),
    FoodItemData(
      petId: 'pet-004',
      username: 'Sue Flay',
      imagePath: 'assets/images/dog_food/dog_food3.jpg',
      zipcode: '96081',
    ),
  ];

  String getPetId(FoodItemData foodItemData) {
    return foodItemData.petId;
  }

  /// The singleton instance providing access to all user data for clients.
  FoodItemDB foodItemDB = FoodItemDB();
}
