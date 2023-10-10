
class ForumAccountData {
  ForumAccountData({
    required this.id,
    required this.username,
  });

  String id;
  String username;

}

/// Provides access to and operations on all defined users.
class ForumAccountDB {

  final List<ForumAccountData> _forumAccountData = [
    ForumAccountData(
      id: 'forum_account-001',
      username: 'Jeff',
    ),
    ForumAccountData(
      id: 'forum_account-002',
      username: 'dogowner1992',
    ),
    ForumAccountData(
      id: 'forum_account-003',
      username: 'cat2',
    ),
  ];


  /// The singleton instance providing access to all user data for clients.
  ForumAccountDB forumAccountDB = ForumAccountDB();
}
