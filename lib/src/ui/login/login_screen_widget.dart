import 'package:flutter/material.dart';
import 'package:trendit/src/domain/api/api_service.dart';
import 'package:trendit/src/domain/api/auth_request.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/common/gradient_container_widget.dart';
import 'package:trendit/src/ui/common/trendit_logo_circle_widget.dart';
import 'package:trendit/src/ui/home/home_screen_widget.dart';
import 'package:trendit/src/ui/login/register_screen_widget.dart';
import 'package:trendit/src/ui/settings/prefs.dart';
import 'package:trendit/src/util/dialogs.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final APIService apiService = APIService.instance;

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

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final String token = await apiService.login(AuthRequest(email: email, password: password));
      print('Login successful');
      await StorageHelper.saveString(SETTINGS_EMAIL, email);
      await StorageHelper.saveString(SETTINGS_TOKEN, token);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      // Handle APIException
      print('API Exception occurred: $e');
      showAppDialog(context, "Login Error", e.toString(), () {});
    } finally {
      setState(() {
        _isLoading = false; // End the loading state after login request finishes
      });
    }
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
                      TrenditRoundLogo(),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isButtonDisabled || _isLoading
                            ? null
                            : () {
                                _performLogin(context);
                              },
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 3),
                              )
                            : const Text(
                                "Log in",
                                style: TextStyle(fontSize: 18.0),
                              ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => SignUpScreen()));
                        },
                        child: const Text(
                          "Sign up",
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
}
