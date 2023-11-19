import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'food_item.freezed.dart';
part 'food_item.g.dart';

@freezed
class FoodItem with _$FoodItem {
  const factory FoodItem({
    required String id,
    required String petId,
    required String userId,
    required String imagePath,
    required double calories,
    required double protein,
    required double fat,
    String? zipcode,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) => _$FoodItemFromJson(json);

  static Future<List<FoodItem>> checkInitialFoodItemData() async {
    String content = await rootBundle.loadString('assets/initial_data/food_item.json');
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => FoodItem.fromJson(jsonData)).toList();
  }
}
