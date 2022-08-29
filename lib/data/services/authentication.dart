import 'package:hive/hive.dart';

import '../model/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('userBox');

    //Initialize user table with one user.
    if (!_users.isNotEmpty) {
      await _users.add(User('user', 576777));
    }
  }

  Future<String?> authenticateUser(
      final String username, final int password) async {
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
