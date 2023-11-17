import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/user/data/user_providers.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import 'signup.dart';

class AuthNotifier extends StateNotifier<UserData?> {
  final UserDB _userDB;

  AuthNotifier(this._userDB) : super(null);

  Future<void> loginUser(String email) async {
    UserData? user = _userDB.getUserByEmail(email);
    if (user != null) {
      state = user;
    } else {
      state = null;
      // Handle invalid login attempt
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, UserData?>((ref) {
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
              onChanged: (email) {
                // Might remove this since there's no need to do anything here as the value is directly managed by the controller
              },
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
                    await ref.read(authProvider.notifier).loginUser(email);

                    // Check if user is logged in successfully
                    if (ref.watch(authProvider) != null) {
                      final loggedInUser = ref.read(authProvider);

                      // Navigate to the next screen while passing the user data
                      Navigator.pushReplacementNamed(
                        context,
                        '/navbar',
                        arguments:
                            loggedInUser, // Pass the user data as arguments
                      );
                    } else {
                      // Handle invalid login attempt
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Invalid email or password. Please try again.'),
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
