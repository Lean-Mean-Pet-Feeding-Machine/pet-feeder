import 'package:flutter/material.dart';
import 'package:pet_feeder/features/food_item/presentation/food_catalog.dart';
import 'package:pet_feeder/features/forum/presentation/forum.dart';
import 'package:pet_feeder/features/pet/presentation/pet_list_view.dart';
import 'package:pet_feeder/features/pet_schedule/presentation/pet_schedule.dart';
import 'package:pet_feeder/features/user/domain/user_db.dart';
import 'package:pet_feeder/features/vet/presentation/myvet.dart';

class BottomNavbar extends StatefulWidget {
  final UserData? currentUser;
  //passing user data
  const BottomNavbar({required this.currentUser, Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;

  // Use late keyword to indicate that _pages will be initialized before using it
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize _pages list in the constructor
    _pages = [
      PetListPage(currentUser: widget.currentUser),
      SchedulePage(),
      MyVetMessagingPage(),
      ForumPage(),
      FoodCatalogPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.pets),
            icon: Icon(Icons.pets_outlined),
            label: 'Pets',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Schedule',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.vaccines),
            icon: Icon(Icons.vaccines_outlined),
            label: 'Vet',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.forum),
            icon: Icon(Icons.forum_outlined),
            label: 'Forum',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.food_bank),
            icon: Icon(Icons.food_bank_outlined),
            label: 'Food',
          ),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (index) =>
            {setState(() => currentIndex = index)},
      ),
    );
  }
}
