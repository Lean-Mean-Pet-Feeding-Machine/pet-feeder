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
    // String content1 = await rootBundle.loadString('pet.json');
    String content = '''
[
  {
    "id": "pet-002",
    "ownerId": "user-001",
    "name": "Mittens",
    "weight": [12.3],
    "when": ["2019-01-22T00:00:00Z"],
    "age": "2018-01-22",
    "species": "Cat",
    "imagePath": "assets/images/cat1.png",
    "schedule": ["20:30", "08:00"],
    "breed": "Siamese Cat"
  }
]''';
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
