import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/register_screen.dart';
import '../presentation/screens/chat_screen.dart';
import '../presentation/screens/onboarding/onboarding_screen_one.dart';
import '../presentation/screens/onboarding/onboarding_screen_two.dart';
import '../presentation/screens/onboarding/onboarding_screen_three.dart';
import '../di/injection.dart';
import '../presentation/viewmodel/login_viewmodel.dart';
import '../presentation/viewmodel/register_viewmodel.dart';
import '../presentation/viewmodel/chat_viewmodel.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => getIt<LoginViewModel>(),
            child: LoginScreen(
              onLoginSuccess: () {
                Navigator.pushReplacementNamed(_, '/onboarding1');
              },
              onRegisterClick: () {
                Navigator.pushNamed(_, '/register');
              },
            ),
          ),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => getIt<RegisterViewModel>(),
            child: RegisterScreen(
              onRegisterSuccess: () {
                Navigator.pop(_);
              },
              onLoginClick: () {
                Navigator.pop(_);
              },
            ),
          ),
        );
      case '/onboarding1':
        return MaterialPageRoute(
          builder: (_) => OnboardingScreenOne(
            onNext: () {
              Navigator.pushReplacementNamed(_, '/onboarding2');
            },
          ),
        );
      case '/onboarding2':
        return MaterialPageRoute(
          builder: (_) => OnboardingScreenTwo(
            onNext: () {
              Navigator.pushReplacementNamed(_, '/onboarding3');
            },
          ),
        );
      case '/onboarding3':
        return MaterialPageRoute(
          builder: (_) => OnboardingScreenThree(
            onStart: () {
              Navigator.pushReplacementNamed(_, '/chat');
            },
          ),
        );
      case '/chat':
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => ChatViewModel(),
            child: ChatScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
