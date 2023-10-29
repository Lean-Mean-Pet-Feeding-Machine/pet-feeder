
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  ForumAccountDB(this.ref);
  final ProviderRef<ForumAccountDB> ref;

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
}
