import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The data associated with users.
class UserData {
  UserData({
    required this.id,
    required this.email,
    required this.userName,
    required this.password,
    this.imagePath,
    this.zipCode,
    this.schedule,
    this.pets,
  });

  String id;
  String email;
  String userName;
  String password;
  String? imagePath; // Path to user profile picture (pfp)
  String? zipCode;
  List<String>? schedule;
  List<String>? pets; // List of pets the user owns
}

/// Provides access to and operations on all defined users.
class UserDB {
  UserDB(this.ref);
  final ProviderRef<UserDB> ref;

  final List<UserData> _users = [
    UserData(
      id: 'user-001',
      email: 'Mark@hawaii.edu',
      userName: 'Mark',
      password: 'password',
      imagePath: 'assets/images/user_pfp/user1.jpg',
      zipCode: '12345',
      schedule: ['T8:30:00', 'T14:00:00', 'T21:30:00', 'T20:30:00'],
      pets: ['Dog', 'Cat'],
    ),
    UserData(
      id: 'user-002',
      email: 'Elon@gmail.com',
      userName: 'Elon',
      password: 'password',
      imagePath: 'assets/images/user_pfp/user2.jpg',
      zipCode: '98622',
      schedule: ['T8:30:00', 'T20:30:00'],
      pets: ['Dog'],
    ),
    UserData(
      id: 'user-003',
      email: 'ArianaG@hawaii.edu',
      userName: 'Ariana',
      password: 'password',
      imagePath: 'assets/images/user_pfp/user3.jpg',
      zipCode: '98455',
      schedule: ['T6:30:00', 'T8:30:00', 'T22:00:00'],
      pets: ['Dog', 'Dog', 'Cat'],
    ),
  ];

  List<String> getUserIDs() {
    return _users.map((data) => data.id).toList();
  }

  UserData getUser(userID) {
    return _users.firstWhere((data) => data.id == userID);
  }

  List<String> getAssociatedUserIDs(String zipCode) {
    return getUserIDs()
        .where((userID) => getUser(userID).zipCode == zipCode)
        .toList();
  }

  UserData? getUserByEmail(String email) {
    print('Searching for user with email: $email');
    var user = _users.firstWhereOrNull(
        (user) => user.email.toLowerCase() == email.toLowerCase());
    print('Found user: $user');
    return user;
  }

  void addUser(UserData userData) {
    _users.insert(_users.length, userData);
  }
}
