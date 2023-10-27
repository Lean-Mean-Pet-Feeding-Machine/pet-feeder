// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/food_catalog.dart';
import 'package:pet_feeder/src/sample_feature/bottom_navbar.dart';
import 'package:pet_feeder/src/sample_feature/pet_info.dart';
import 'package:pet_feeder/src/sample_feature/side_menu.dart';
import 'login.dart';
import 'signup.dart';
import 'myvet.dart';
import 'schedule.dart';
import 'forum.dart';
import 'src/app.dart';
import 'src/settings/settings_view.dart';
import 'src/data_model/pet_db.dart';
import 'src/data_model/user_db.dart';

void main() async {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: MyApp(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/drawer': (context) {
            // Extract the arguments passed to the route
            final UserData? currentUser =
                ModalRoute.of(context)!.settings.arguments as UserData?;

            // Return the CustomDrawer widget with the extracted user data
            return CustomDrawer(currentUser: currentUser);
          },
          '/pet-info': (context) {
            // Extract the arguments passed to the route
            final PetData pet =
                ModalRoute.of(context)!.settings.arguments as PetData;

            // Return the PetInfo widget with the extracted pet data
            return PetInfo(pet: pet);
          },
          '/myapp': (context) => MyApp(),
          '/myvet': (context) => MyVetMessagingPage(),
          '/schedule': (context) => SchedulePage(),
          '/food-catalog': (context) => FoodCatalogPage(),
          '/forum': (context) => ForumPage(),
          '/navbar': (context) {
            // Extract the arguments passed to the route
            final UserData? loggedInUser =
                ModalRoute.of(context)!.settings.arguments as UserData?;

            // Return the BottomNavbar widget with the extracted user data
            return BottomNavbar(currentUser: loggedInUser);
          },
          '/settings': (context) => SettingsView(),
        },
      ),
    ),
  );
}
