import 'dart:math';

/// The data associated with users.

class FoodItemData {
  FoodItemData({
    required this.petId,
    required this.userId,
    required this.imagePath,
    this.zipcode,
  }) {
   nutrients = generateMap();
  }

  String petId;
  String userId;
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
      userId: 'user-001',
      imagePath: 'assets/images/dog_food/dog_food1.jpg',
      zipcode: '96838',
    ),
    FoodItemData(
      petId: 'pet-002',
      userId: 'user-001',
      imagePath: 'assets/images/dog_food/dog_food2.jpg',
      zipcode: '96789',
    ),
    FoodItemData(
      petId: 'pet-003',
      userId: 'user-002',
      imagePath: 'assets/images/dog_food/dog_food2.jpg',
      zipcode: '96850',
    ),
    FoodItemData(
      petId: 'pet-004',
      userId: 'user-002',
      imagePath: 'assets/images/dog_food/dog_food3.jpg',
      zipcode: '96081',
    ),
    FoodItemData(
      petId: 'pet-005',
      userId: 'user-003',
      imagePath: 'assets/images/dog_food/dog_food3.jpg',
      zipcode: '96081',
    ),
  ];

  List<FoodItemData> getFoodItems() {
    return _foodItems.toList();
  }

  List<FoodItemData> getFoodItemsForPet(String petId) {
    return _foodItems.where((foodItem) => foodItem.petId == petId).toList();
  }

  List<FoodItemData> getFoodItemsForUser(String userId) {
    return _foodItems.where((foodItem) => foodItem.userId == userId).toList();
  }
}
FoodItemDB foodItemDB = FoodItemDB();
