import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String userName,
    required String password,
    String? imagePath,
    String? zipCode,
    List<String>? schedule,
    List<String>? pets,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static Future<List<User>> checkInitialUserData() async {
    String content = await rootBundle.loadString('assets/initial_data/user.json');
    List<dynamic> initialData = json.decode(content);
    return initialData.map((jsonData) => User.fromJson(jsonData)).toList();
  }

}
