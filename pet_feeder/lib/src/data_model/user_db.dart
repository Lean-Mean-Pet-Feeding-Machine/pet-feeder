/// The data associated with users.
class UserData {
  UserData({
    required this.id,
    required this.email,
    required this.userName,
    required this.imagePath,
    required this.zipCode,
    required this.schedule,
    required this.pets,
  });

  String id;
  String email;
  String userName;
  String imagePath; // Path to user profile picture (pfp)
  String zipCode;
  List<String> schedule;
  List<String> pets; // List of pets the user owns
}

/// Provides access to and operations on all defined users.
class UserDB {
  final List<UserData> _users = [
    UserData(
      id: 'user-001',
      email: 'user1@example.com',
      userName: 'Mark',
      imagePath: 'assets/images/user_pfp/user1.jpg',
      zipCode: '12345',
      schedule: ['T8:30:00', 'T14:00:00', 'T21:30:00', 'T20:30:00'],
      pets: ['Dog', 'Cat'],
    ),
    UserData(
      id: 'user-002',
      email: 'user2@example.com',
      userName: 'Elon',
      imagePath: 'assets/images/user_pfp/user2.jpg',
      zipCode: '98622',
      schedule: ['T8:30:00', 'T20:30:00'],
      pets: ['Dog'],
    ),
    UserData(
      id: 'user-003',
      email: 'user3@example.com',
      userName: 'Ariana',
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
}

/// The singleton instance providing access to all user data for clients.
UserDB userDB = UserDB();


//TODO: The user_db.dart file should define a variable called currentUserID. This specifies the currently logged in user. 