import '../database/dao/user_dao.dart';
import '../database/entity/user.dart';

class UserRepository {
  final UserDao userDao;

  UserRepository(this.userDao);

  Future<void> insert(User user) async {
    await userDao.insertUser(user);
  }

  Future<User?> getUserByEmail(String email) async {
    return await userDao.getUserByEmail(email);
  }
}
