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
    required List<(double, DateTime)> weight,
    required DateTime age,
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
    "id": "pet-001",
    "name": "Spot",
    "weight": [
      {
        "weight": 34.4,
        "date": "2022-10-22"
      },
      {
        "weight": 36.4,
        "date": "2022-11-22"
      },
      {
        "weight": 32.4,
        "date": "2022-12-22"
      }
    ],
    "age": "2022-01-22",
    "species": "Dog",
    "imagePath": "assets/images/dog1.png",
    "schedule": ["20:30", "08:00"],
    "breed": "Beagle"
  },
  {
    "id": "pet-002",
    "name": "Mittens",
    "weight": [
      {
        "weight": 12.4,
        "date": "2019-10-22"
      }
    ],
    "age": "2018-01-22",
    "species": "Cat",
    "imagePath": "assets/images/cat1.png",
    "schedule": ["20:30", "08:00"],
    "breed": "Siamese Cat"
  }
]
    ''';
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => Pet.fromJson(jsonData)).toList();
  }

  double calculateIdealWeight(double bcsScore) {
    double idealWeight =  bcsScore - 4;
    idealWeight = idealWeight * 10;
    idealWeight = idealWeight + 100;
    idealWeight = 100 / idealWeight;
    idealWeight = idealWeight * weight.last.$1;
    return idealWeight;
  }
}
