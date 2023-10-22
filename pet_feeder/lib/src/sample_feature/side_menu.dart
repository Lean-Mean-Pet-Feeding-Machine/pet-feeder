import 'package:flutter/material.dart';
import '../data_model/user_db.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user data
    UserData currentUser = userDB.getUser(
        'user-001'); // TODO: Replace 'user-001' with the actual user ID

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
                  backgroundImage: AssetImage(currentUser.imagePath),
                ),
                SizedBox(height: 10),
                // Display the user's name and email
                Text(
                  currentUser.userName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentUser.email,
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
