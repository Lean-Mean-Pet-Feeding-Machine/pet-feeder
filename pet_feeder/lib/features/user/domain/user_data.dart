import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@Freezed()
class UserData with _$UserData {
  const factory UserData({
    required String id,
    required String email,
    required String userName,
    required String password,
    String? imagePath,
    String? zipCode,
    List<String>? schedule,
    List<String>? pets,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  // String id;
  // String email;
  // String userName;
  // String password;
  // String? imagePath; // Path to user profile picture (pfp)
  // String? zipCode;
  // List<String>? schedule;
  // List<String>? pets; // List of pets the user owns
}
