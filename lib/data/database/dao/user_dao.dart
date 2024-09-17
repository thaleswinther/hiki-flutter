import 'package:floor/floor.dart';
import '../entity/user.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(User user);

  @Query('SELECT * FROM user_table WHERE email = :email')
  Future<User?> getUserByEmail(String email);
}
