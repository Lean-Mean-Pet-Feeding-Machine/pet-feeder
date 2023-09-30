// import 'dart:js';

import 'package:flutter/material.dart';
// import 'package:pet_feeder/pet_info.dart';
import 'login.dart';
import 'signup.dart';
import 'myvet.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(
    MaterialApp(
      home: SignUpPage(), // Show SignUpPage initially
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(), // Route for Login Page
        '/signup': (context) => SignUpPage(), // Route for SignUpPage
        // '/pet-info': (context) => PetInfo(), // Route for SignUpPage
        '/myapp': (context) =>
            MyApp(settingsController: settingsController), // Route for MyApp
        '/myvet': (context) => MyVetMessagingPage(), //Route for My Vet page
      },
    ),
  );
}
