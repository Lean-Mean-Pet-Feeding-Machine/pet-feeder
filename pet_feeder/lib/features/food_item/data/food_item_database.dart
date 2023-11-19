import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/food_item/domain/food_item.dart';
import '../../../repositories/firestore/firestore_path.dart';
import '../../../repositories/firestore/firestore_service.dart';

/// Provides access to the Firestore database storing [FoodItem] documents.
class FoodItemDatabase {
  FoodItemDatabase(this.ref);

  final ProviderRef<FoodItemDatabase> ref;

  final _service = FirestoreService.instance;

  Stream<List<FoodItem>> watchFoodItems() => _service.watchCollection(
      path: FirestorePath.foodItems(),
      builder: (data, documentId) => FoodItem.fromJson(data!));

  Stream<FoodItem> watchFoodItemData(String foodItemId) => _service.watchDocument(
      path: FirestorePath.foodItem(foodItemId),
      builder: (data, documentId) => FoodItem.fromJson(data!));

  Future<List<FoodItem>> fetchFoodItemDatas() => _service.fetchCollection(
      path: FirestorePath.foodItems(),
      builder: (data, documentId) => FoodItem.fromJson(data!));

  Future<FoodItem> fetchFoodItemData(String foodItemId) => _service.fetchDocument(
      path: FirestorePath.foodItem(foodItemId),
      builder: (data, documentId) => FoodItem.fromJson(data!));

  Future<void> setFoodItemData(FoodItem foodItem) => _service.setData(
      path: FirestorePath.foodItem(foodItem.id), data: foodItem.toJson());

  Future<void> setFoodItemDataDelayed(FoodItem foodItem) => Future.delayed(
      const Duration(milliseconds: 2000),
          () => _service.setData(
          path: FirestorePath.foodItem(foodItem.id), data: foodItem.toJson()));

  Future<void> setFoodItemDataError(FoodItem foodItem) =>
      Future.delayed(const Duration(milliseconds: 2000), () => throw Error());

  Future<void> deleteFoodItemData(FoodItem foodItem) =>
      _service.deleteData(path: FirestorePath.foodItem(foodItem.id));
}
