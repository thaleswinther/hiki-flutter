import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hiki_flutter/data/database/dao/user_dao.dart';
import 'package:hiki_flutter/data/database/entity/user.dart';
import 'package:hiki_flutter/data/repository/user_repository.dart';

@GenerateMocks([UserDao])
import 'user_repository_test.mocks.dart';

void main() {
  late UserRepository userRepository;
  late MockUserDao mockUserDao;

  setUp(() {
    mockUserDao = MockUserDao();
    userRepository = UserRepository(mockUserDao);
  });

  group('UserRepository', () {
    test('insert calls insertUser on UserDao', () async {
      final user = User(email: 'test@example.com', password: 'password123', username: 'testuser');

      when(mockUserDao.insertUser(user)).thenAnswer((_) => Future<void>.value());

      await userRepository.insert(user);

      verify(mockUserDao.insertUser(user)).called(1);
    });

    test('getUserByEmail calls getUserByEmail on UserDao', () async {
      const email = 'test@example.com';
      final user = User(email: email, password: 'password123', username: 'testuser');

      when(mockUserDao.getUserByEmail(email)).thenAnswer((_) => Future.value(user));

      final result = await userRepository.getUserByEmail(email);

      verify(mockUserDao.getUserByEmail(email)).called(1);

      expect(result, equals(user));
    });

    test('getUserByEmail returns null when user not found', () async {
      const email = 'nonexistent@example.com';

      when(mockUserDao.getUserByEmail(email)).thenAnswer((_) => Future.value(null));

      final result = await userRepository.getUserByEmail(email);

      verify(mockUserDao.getUserByEmail(email)).called(1);

      expect(result, isNull);
    });

    test('getUserByEmail returns incorrect user', () async {
      const email = 'test@example.com';
      final actualUser = User(email: email, password: 'password123', username: 'actualuser');
      final expectedUser = User(email: email, password: 'differentpassword', username: 'expecteduser');

      when(mockUserDao.getUserByEmail(email)).thenAnswer((_) => Future.value(actualUser));

      final result = await userRepository.getUserByEmail(email);

      verify(mockUserDao.getUserByEmail(email)).called(1);

      expect(result, isNot(equals(expectedUser)));
    });
  });
}