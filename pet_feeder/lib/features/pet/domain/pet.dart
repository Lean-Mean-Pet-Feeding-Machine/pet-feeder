import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../food_item/domain/food_item_db.dart';

part 'pet.freezed.dart';
part 'pet.g.dart';

@freezed
class Pet with _$Pet {
  const Pet._();

  const factory Pet({
    required String id,
    required String ownerId,
    required String name,
    required List<double> weight,
    required List<String> when,
    required String age,
    required String species,
    required String imagePath,
    required List<String> schedule,
    String? foodItemId,
    String? breed,
    double? bcsScore,
    double? idealWeight,
  }) = _Pet;

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  static Future<List<Pet>> checkInitialPetData() async {
    String content = await rootBundle.loadString('assets/initial_data/pet.json');
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Pet.fromJson(jsonData)).toList();
  }

  double calculateIdealWeight(double bcsScore) {
    double idealWeight =  bcsScore - 4;
    idealWeight = idealWeight * 10;
    idealWeight = idealWeight + 100;
    idealWeight = 100 / idealWeight;
    idealWeight = idealWeight * weight.last;
    return idealWeight;
  }
}
