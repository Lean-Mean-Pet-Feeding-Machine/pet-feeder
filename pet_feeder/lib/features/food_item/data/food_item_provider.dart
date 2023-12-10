import 'package:pet_feeder/features/food_item/data/food_item_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/food_item.dart';

part 'food_item_provider.g.dart';

@riverpod
FoodItemDatabase foodItemDatabase(FoodItemDatabaseRef ref) {
  return FoodItemDatabase(ref);
}

@riverpod
Stream<List<FoodItem>> foodItems(FoodItemsRef ref) {
  final database = ref.watch(foodItemDatabaseProvider);
  return database.watchFoodItems();
}
