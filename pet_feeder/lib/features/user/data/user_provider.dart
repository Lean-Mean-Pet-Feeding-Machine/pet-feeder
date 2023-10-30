import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/user_db.dart';

final userDBProvider = Provider<UserDB>((ref) => UserDB(ref));
