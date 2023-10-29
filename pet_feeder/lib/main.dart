import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/authentication/presentation/login.dart';
import 'package:pet_feeder/features/authentication/presentation/signup.dart';
import 'package:pet_feeder/features/common/settings_view.dart';
import 'package:pet_feeder/features/food_item/presentation/food_catalog.dart';
import 'package:pet_feeder/features/common/bottom_navbar.dart';
import 'package:pet_feeder/features/forum/presentation/forum.dart';
import 'package:pet_feeder/features/pet/domain/pet_db.dart';
import 'package:pet_feeder/features/pet/presentation/pet_info.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'package:pet_feeder/features/pet_schedule/presentation/pet_schedule.dart';
import 'package:pet_feeder/features/vet/presentation/myvet.dart';
import 'app.dart';

void main() async {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: MyApp(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/drawer': (context) => CustomDrawer(),
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
          '/navbar': (context) => BottomNavbar(),
          '/settings': (context) => SettingsView(),
        },
      ),
    ),
  );
}
