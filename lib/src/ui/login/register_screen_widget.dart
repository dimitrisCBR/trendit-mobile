import 'package:flutter/material.dart';
import 'package:trendit/src/domain/api/api_service.dart';
import 'package:trendit/src/domain/api/auth_request.dart';
import 'package:trendit/src/domain/storage_helper.dart';
import 'package:trendit/src/ui/common/gradient_container_widget.dart';
import 'package:trendit/src/ui/common/trendit_logo_circle_widget.dart';
import 'package:trendit/src/ui/home/home_screen_widget.dart';
import 'package:trendit/src/ui/settings/prefs.dart';
import 'package:trendit/src/util/dialogs.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final APIService apiService = APIService.instance;

  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  // Function to simulate login request
  Future<void> _performLogin(BuildContext context) async {}

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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              validator: (input) {
                                return (input != null && input.contains("@"))
                                    ? null
                                    : "Invalid email address";
                              },
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
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (input.length > 6) {
                                  return null;
                                } else {
                                  return "Password too short";
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _repeatPasswordController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.lock_open_outlined),
                                labelText: 'Repeat password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                              validator: (input) {
                                if (input == null || input.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                return (input == _passwordController.text.trim())
                                    ? null
                                    : "Passwords don't match";
                              },
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      _attemptRegistration(context);
                                    },
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 3),
                                    )
                                  : const Text(
                                      "Create account",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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

  void _attemptRegistration(BuildContext context) async {
    if (validateAndSave()) {
      setState(() {
        _isLoading = true; // Start the loading state
      });

      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        final String token =
            await apiService.register(AuthRequest(email: email, password: password));
        print('Sign up successful');
        await StorageHelper.saveString(SETTINGS_EMAIL, email);
        await StorageHelper.saveString(SETTINGS_TOKEN, token);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()),
          (route) => false,
        );
      } catch (e) {
        // Handle APIException
        print('API Exception occurred: $e');
        showAppDialog(context, "Sign up error", e.toString(), () {});
      } finally {
        setState(() {
          _isLoading = false; // End the loading state after login request finishes
        });
      }
    }
  }

  bool validateAndSave() {
    final FormState? form = _formKey.currentState;
    return form != null && form.validate();
  }
}
