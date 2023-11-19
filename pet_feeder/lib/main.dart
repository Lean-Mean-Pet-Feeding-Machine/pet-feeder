import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/features/authentication/presentation/login.dart';
import 'package:pet_feeder/features/authentication/presentation/signup.dart';
import 'package:pet_feeder/features/common/settings_view.dart';
import 'package:pet_feeder/features/food_item/domain/food_item.dart';
import 'package:pet_feeder/features/food_item/presentation/food_catalog.dart';
import 'package:pet_feeder/features/common/bottom_navbar.dart';
import 'package:pet_feeder/features/forum/presentation/forum.dart';
import 'package:pet_feeder/features/pet/domain/pet.dart';
import 'package:pet_feeder/features/pet/domain/pet_db.dart';
import 'package:pet_feeder/features/pet/presentation/pet_info.dart';
import 'package:pet_feeder/features/common/side_menu.dart';
import 'package:pet_feeder/features/pet_schedule/presentation/pet_schedule.dart';
import 'package:pet_feeder/features/user/domain/user.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import 'package:pet_feeder/features/vet/presentation/myvet.dart';
import 'package:pet_feeder/firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await Pet.checkInitialPetData();
  await User.checkInitialUserData();
  await FoodItem.checkInitialFoodItemData();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
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
          final Pet pet =
          ModalRoute.of(context)!.settings.arguments as Pet;

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
    );
  }
}
