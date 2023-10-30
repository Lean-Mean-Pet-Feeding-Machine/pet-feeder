import 'package:flutter/material.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';

class CustomDrawer extends StatelessWidget {
  final UserData? currentUser;

  const CustomDrawer({required this.currentUser});

  @override
  Widget build(BuildContext context) {
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
                // Display the user's name and email
                Text(
                  currentUser?.userName ?? 'Guest',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  currentUser?.email ?? '',
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
