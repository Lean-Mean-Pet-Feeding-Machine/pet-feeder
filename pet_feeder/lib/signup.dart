import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController =
      TextEditingController(); // Separate controller for Confirm Password
  final _emailController = TextEditingController();
  final _zipCodeController =
      TextEditingController(); // Separate controller for Zip Code

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            const Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text('Please register',
                    style: TextStyle(
                      fontSize: 24.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _zipCodeController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Zip Code',
              ),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    _usernameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                    _zipCodeController.clear();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Simulate a sign-up process (replace with your actual sign-up logic)
                    bool signUpSuccessful =
                        true; // Replace with actual sign-up logic

                    if (signUpSuccessful) {
                      Navigator.pushReplacementNamed(context, '/myapp');
                    }
                  },
                  child: const Text('SIGN UP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
