// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String,
      password: json['password'] as String,
      imagePath: json['imagePath'] as String?,
      zipCode: json['zipCode'] as String?,
      schedule: (json['schedule'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pets: (json['pets'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'userName': instance.userName,
      'password': instance.password,
      'imagePath': instance.imagePath,
      'zipCode': instance.zipCode,
      'schedule': instance.schedule,
      'pets': instance.pets,
    };
