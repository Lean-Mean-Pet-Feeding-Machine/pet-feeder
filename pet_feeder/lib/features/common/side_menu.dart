import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/authentication/presentation/login.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the current user from Firebase Authentication
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? firebaseUser = _auth.currentUser;

    // Access the currentUser from the context using the provider
    final UserData? currentUser = context.read();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display the user's profile picture using CircleAvatar
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(currentUser?.imagePath ?? ''),
                ),
                SizedBox(height: 10),
                // Display the user's name (there's no name on Firebase yet)
                Text(
                  currentUser?.userName ?? 'Guest',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  firebaseUser?.email ?? '', // Access the email from Firebase
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings').then((_) {});
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
