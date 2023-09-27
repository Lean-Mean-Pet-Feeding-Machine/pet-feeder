import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(
    MaterialApp(
      //I set the initial route to SignUpPage for testing purposes, feel free to change it to the log in page when ready
      home: SignUpPage(), // Show SignUpPage initially
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // Route for SignUpPage
        '/signup': (context) => SignUpPage(), // Route for SignUpPage
        '/myapp': (context) =>
            MyApp(settingsController: settingsController), // Route for MyApp
      },
    ),
  );
}
