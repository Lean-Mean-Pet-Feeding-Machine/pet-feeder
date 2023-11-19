// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodItemImpl _$$FoodItemImplFromJson(Map<String, dynamic> json) =>
    _$FoodItemImpl(
      id: json['id'] as String,
      petId: json['petId'] as String,
      userId: json['userId'] as String,
      imagePath: json['imagePath'] as String,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      zipcode: json['zipcode'] as String?,
    );

Map<String, dynamic> _$$FoodItemImplToJson(_$FoodItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'userId': instance.userId,
      'imagePath': instance.imagePath,
      'calories': instance.calories,
      'protein': instance.protein,
      'fat': instance.fat,
      'zipcode': instance.zipcode,
    };
