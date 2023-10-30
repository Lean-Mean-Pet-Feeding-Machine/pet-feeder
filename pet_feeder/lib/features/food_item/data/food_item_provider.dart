import 'package:pet_feeder/features/food_item/domain/food_item_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodItemDBProvider = Provider<FoodItemDB>((ref) => FoodItemDB(ref));
