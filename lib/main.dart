import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/home/home_screen_widget.dart';
import 'package:trendit/src/ui/login/login_screen_widget.dart';
import 'package:trendit/src/ui/splash_screen_widget.dart';
import 'package:trendit/src/ui/styles/color_schemes.dart';
import 'package:trendit/src/util/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.initialize();
  await AppConfig.loadConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData baseLightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
    );
    ThemeData lightTheme = baseLightTheme.copyWith(
      textTheme: GoogleFonts.robotoMonoTextTheme(baseLightTheme.textTheme),
    );
    ThemeData baseDarkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
    );
    ThemeData darkTheme = baseDarkTheme.copyWith(
      textTheme: GoogleFonts.robotoMonoTextTheme(baseDarkTheme.textTheme),
    );
    return MaterialApp(
      title: 'Splash Screen Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const HomeScreen(),
      },
    );
  }
}
