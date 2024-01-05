import 'package:flutter/material.dart';
import 'package:trendit/src/storage_helper.dart';

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
  Future<void> _performLogin() async {
    setState(() {
      _isLoading = true; // Start the loading state
    });
    final email = _emailController.text;

    // Simulate a login request delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false; // End the loading state after login request finishes
    });

    await StorageHelper.saveString("username", email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            child: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.purple,
                ],
                // You can also specify stops for more complex gradients
                // stops: [0.3, 0.7],
              ),
            )),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 30.0),
                  child: Column(
                    children: <Widget>[
                      _logoCircle(),
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
                                _performLogin();
                              },
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
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
                          style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
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

  _logoCircle() {
    return Center(
        child: Container(
            width: 150, // Adjust size as needed
            height: 150, // Adjust size as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // Change the circle color here
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/trendit_icon.png', // Replace with your asset image path
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            )));
  }
}
