import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posty/core/constants/app_routes.dart';
import 'package:posty/core/responsive/responsive_config.dart';
import 'package:posty/core/theme/app_theme.dart';
import 'package:posty/features/auth/views/login_view.dart';
import 'package:posty/features/auth/views/register_view.dart';
import 'package:posty/features/main/view/home_view.dart';
import 'package:posty/firebase_options.dart';
import 'package:posty/l10n/app_localizations.dart';
import 'package:posty/providers/language_provider.dart';
import 'package:posty/providers/theme_provider.dart';
import 'package:posty/providers/user_provider.dart';
import 'package:posty/services/prefs_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await PrefsService.init();

  final firebaseUser = FirebaseAuth.instance.currentUser;
  final userProvider = UserProvider();

  if (firebaseUser != null) {
    await userProvider.getUserData(firebaseUser.uid);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
      ],
      child: MyApp(isLoggedIn: firebaseUser != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    ResponsiveConfig.init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.currentLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentMode,
      initialRoute: isLoggedIn ? AppRoutes.homeView : AppRoutes.registerView,
      routes: {
        AppRoutes.registerView: (context) => const RegisterView(),
        AppRoutes.loginView: (context) => const LoginView(),
        AppRoutes.homeView: (context) => const HomeView(),
      },
    );
  }
}
