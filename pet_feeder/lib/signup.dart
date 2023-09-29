import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 30.0),
            Container(
              height: 100.0, // Adjust the height as needed for your GIF
              child: Image.asset(
                  'assets/images/dogwag.gif'), // Replace with your GIF asset
            ),
            const SizedBox(height: 10.0), // Add spacing
            const Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Text(
                  'Please register:',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
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
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.center,
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
