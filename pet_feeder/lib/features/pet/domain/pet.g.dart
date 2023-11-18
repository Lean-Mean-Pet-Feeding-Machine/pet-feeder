// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetImpl _$$PetImplFromJson(Map<String, dynamic> json) => _$PetImpl(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      name: json['name'] as String,
      weight: (json['weight'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      when: (json['when'] as List<dynamic>).map((e) => e as String).toList(),
      age: json['age'] as String,
      species: json['species'] as String,
      imagePath: json['imagePath'] as String,
      schedule:
          (json['schedule'] as List<dynamic>).map((e) => e as String).toList(),
      foodItemId: json['foodItemId'] as String?,
      breed: json['breed'] as String?,
      bcsScore: (json['bcsScore'] as num?)?.toDouble(),
      idealWeight: (json['idealWeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PetImplToJson(_$PetImpl instance) => <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'weight': instance.weight,
      'when': instance.when,
      'age': instance.age,
      'species': instance.species,
      'imagePath': instance.imagePath,
      'schedule': instance.schedule,
      'foodItemId': instance.foodItemId,
      'breed': instance.breed,
      'bcsScore': instance.bcsScore,
      'idealWeight': instance.idealWeight,
    };
