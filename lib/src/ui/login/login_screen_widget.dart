import 'package:flutter/material.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/common/gradient_container_widget.dart';
import 'package:trendit/src/ui/home/home_screen_widget.dart';
import 'package:trendit/src/ui/settings/prefs.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isButtonDisabled = true;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to validate email and password inputs
  void _validateInputs() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check if both email and password are valid
    final isValidEmail = email.isNotEmpty && email.contains('@');
    final isValidPassword = password.isNotEmpty && password.length >= 6;

    // Enable or disable the button based on input validity
    setState(() {
      _isButtonDisabled = !(isValidEmail && isValidPassword);
    });
  }

  // Function to simulate login request
  Future<void> _performLogin(BuildContext context) async {
    setState(() {
      _isLoading = true; // Start the loading state
    });
    final email = _emailController.text;

    // Simulate a login request delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false; // End the loading state after login request finishes
    });

    await StorageHelper.saveString(SETTINGS_EMAIL, email);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: GradientContainer(),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 30.0),
                  child: Column(
                    children: <Widget>[
                      _logoCircle(context),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isButtonDisabled || _isLoading
                            ? null
                            : () {
                                // Perform login when the button is enabled
                                _performLogin(context);
                              },
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(fontSize: 18.0),
                              ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _logoCircle(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color tint;
    if (isDarkMode) {
      tint = Colors.white; // Choose a color for dark mode
    } else {
      tint = Colors.black; // Choose a color for light mode
    }
    return Center(
        child: Container(
            width: 150, // Adjust size as needed
            height: 150, // Adjust size as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onPrimary, // Change the circle color here
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    tint, // Tint color
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'assets/images/trendit_icon.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              ),
            )));
  }
}
