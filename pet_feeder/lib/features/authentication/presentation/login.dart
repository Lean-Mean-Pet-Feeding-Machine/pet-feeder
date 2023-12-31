import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/user/data/user_providers.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier extends StateNotifier<UserCredential?> {
  final UserDB _userDB;

  AuthNotifier(this._userDB) : super(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = userCredential;
    } catch (e) {
      print('Error during login: $e');
      state = null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = null;
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, UserCredential?>((ref) {
  return AuthNotifier(ref.read(userDBProvider));
});

final _passwordController = TextEditingController();

class LoginPage extends ConsumerWidget {
  // Manage the email input
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset('assets/images/main_logo.png'),
                const Text(
                  'PetFed',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const Text(
                  'Your Lean Mean Pet Feeding Machine',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90.0),
            // Bind the TextField with email input
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
              onChanged: (email) {},
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
            Row(
              children: [
                TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: const Text('Register')),
                const Spacer(),
                TextButton(
                    onPressed: () => {/*TODO Route to Forgot Password page*/},
                    child: const Text('Forgot password')),
              ],
            ),
            const SizedBox(height: 12.0),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    // Get email from the TextEditingController
                    String email = _emailController.text.trim();
                    // Pass the email to loginUser function
                    await ref.read(authProvider.notifier).loginUser(
                          email,
                          _passwordController.text,
                        );

                    // Check if user is logged in successfully
                    if (ref.watch(authProvider) != null) {
                      // Navigate to the next screen
                      Navigator.pushReplacementNamed(
                        context,
                        '/navbar',
                      );
                    } else {
                      // Handle invalid login attempt
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Invalid email or password. Please try again.',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
