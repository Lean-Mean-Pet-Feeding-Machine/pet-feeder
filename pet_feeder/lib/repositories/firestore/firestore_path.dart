/// Defines the domain model path strings for [FirestoreService].
class FirestorePath {
  static String pet(String petID) => 'pets/$petID';
  static String pets() => 'pets';

  static String foodItem(String foodItemID) => 'foodItems/$foodItemID';
  static String foodItems() => 'foodItems';

  static String user(String userID) => 'users/$userID';
  static String users() => 'users';
}
