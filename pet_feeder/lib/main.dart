// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:pet_feeder/food_catalog.dart';
import 'package:pet_feeder/src/sample_feature/bottom_navbar.dart';
import 'package:pet_feeder/src/sample_feature/pet_info.dart';
// import 'package:pet_feeder/pet_info.dart';
import 'login.dart';
import 'signup.dart';
import 'myvet.dart';
import 'schedule.dart';
import 'forum.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(
    MaterialApp(
      theme: ThemeData(
        hintColor: Color.fromARGB(255, 58, 159, 241),
        scaffoldBackgroundColor:
            Color.fromARGB(82, 184, 250, 255), // Background color (light blue)
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(
              255, 23, 148, 250), // Primary color for light theme
          secondary: Color(0xFF64B5F6), // Secondary color for light theme
        ),
      ),
      home: SignUpPage(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/pet-info': (context) => PetInfo(),
        '/myapp': (context) => MyApp(settingsController: settingsController),
        '/myvet': (context) => MyVetMessagingPage(),
        '/schedule': (context) => SchedulePage(),
        '/food-catalog': (context) => FoodCatalogPage(),
        '/forum': (context) => ForumPage(),
        '/navbar': (context) => BottomNavbar(),
      },
    ),
  );
}
