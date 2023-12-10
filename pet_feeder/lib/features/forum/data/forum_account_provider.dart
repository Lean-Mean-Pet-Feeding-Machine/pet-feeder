import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/forum/domain/forum_account_db.dart';

final forumAccountDBProvider =
    Provider<ForumAccountDB>((ref) => ForumAccountDB(ref));
