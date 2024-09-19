import 'package:flutter/material.dart';
import 'package:hiki_flutter/presentation/viewmodel/chat_viewmodel.dart';
import 'package:hiki_flutter/presentation/viewmodel/login_viewmodel.dart';
import 'package:hiki_flutter/presentation/viewmodel/register_viewmodel.dart';
import 'package:provider/provider.dart';
import 'navigation/app_router.dart';
import 'di/injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => getIt<LoginViewModel>()),
        Provider(create: (_) => getIt<RegisterViewModel>()),
        Provider(create: (_) => getIt<ChatViewModel>()),
      ],
      child: MaterialApp(
        title: 'Hiki Flutter',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateRoute: _appRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
