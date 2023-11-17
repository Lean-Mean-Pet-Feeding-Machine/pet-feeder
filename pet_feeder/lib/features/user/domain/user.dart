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

  // String id;
  // String email;
  // String userName;
  // String password;
  // String? imagePath; // Path to user profile picture (pfp)
  // String? zipCode;
  // List<String>? schedule;
  // List<String>? pets; // List of pets the user owns
}
