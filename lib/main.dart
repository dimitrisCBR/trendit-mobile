import 'package:flutter/material.dart';
import 'package:trendit/src/home_screen_widget.dart';
import 'package:trendit/src/login_screen_widget.dart';
import 'package:trendit/src/splash_screen_widget.dart';
import 'package:trendit/src/storage_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/main': (context) => HomeScreen(),
      },
    );
  }
}
