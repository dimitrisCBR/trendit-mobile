import 'package:flutter/material.dart';
import 'package:trendit/src/home_screen_widget.dart';
import 'package:trendit/src/login_screen_widget.dart';
import 'package:trendit/src/storage_helper.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Add a bit delay so Splash doesn't flash
    await Future.delayed(const Duration(seconds: 1));

    String? username = StorageHelper.getString("username");
    bool isLoggedIn = username?.isNotEmpty ?? false;

    // Determine the starting page based on login status
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}