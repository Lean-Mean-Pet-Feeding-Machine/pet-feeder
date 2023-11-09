import 'package:freezed_annotation/freezed_annotation.dart';
import '../../food_item/domain/food_item_db.dart';

part 'pet_data.freezed.dart';
part 'pet_data.g.dart';

@Freezed()
class PetData with _$PetData {
  const factory PetData({
        required String id,
        required String name,
        required List<(double, DateTime)> weight,
        required DateTime age,
        required String species,
        required String imagePath,
        required List<String> schedule,
        String? foodItemId,
        String? breed,
        double? bcsScore,
        double? idealWeight,
      }) = _PetData;

  factory PetData.fromJson(Map<String, dynamic> json) => _$PetDataFromJson(json);

  // String id;
  // String name;
  // List<(double, DateTime)> weight;
  // DateTime age;
  // String species;
  // String imagePath;
  // List<String> schedule;
  // FoodItemData foodItemData;
  // String? breed;
  // double? bcsScore;
  // double? idealWeight;
  //
  // double calculateIdealWeight(double bcsScore) {
  //   double idealWeight =  bcsScore - 4;
  //   idealWeight = idealWeight * 10;
  //   idealWeight = idealWeight + 100;
  //   idealWeight = 100 / idealWeight;
  //   idealWeight = idealWeight * weight.last.$1;
  //   this.bcsScore = bcsScore;
  //   this.idealWeight = idealWeight;
  //   print(this.idealWeight);
  //   return idealWeight;
  // }
}
