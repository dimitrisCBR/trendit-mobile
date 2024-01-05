import 'package:flutter/material.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/common/gradient_container_widget.dart';
import 'package:trendit/src/ui/home/home_screen_widget.dart';
import 'package:trendit/src/ui/login/login_screen_widget.dart';

import 'settings/prefs.dart';

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
    await Future.delayed(const Duration(seconds: 2));

    String? username = StorageHelper.getString(SETTINGS_EMAIL);
    String? token = StorageHelper.getString(SETTINGS_TOKEN);
    bool isLoggedIn = (username?.isNotEmpty ?? false) && (token?.isNotEmpty ?? false);

    print("Username: ${username}");

    // Determine the starting page based on login status
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
