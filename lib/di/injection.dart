import 'package:get_it/get_it.dart';
import '../data/database/app_database.dart';
import '../data/repository/user_repository.dart';
import '../presentation/viewmodel/login_viewmodel.dart';
import '../presentation/viewmodel/register_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);

  getIt.registerLazySingleton<UserRepository>(() => UserRepository(database.userDao));
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(userRepository: getIt<UserRepository>()));
  getIt.registerFactory<RegisterViewModel>(() => RegisterViewModel(userRepository: getIt<UserRepository>()));
}
