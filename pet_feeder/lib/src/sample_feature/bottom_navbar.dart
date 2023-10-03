import 'package:flutter/material.dart';
import 'package:pet_feeder/myvet.dart';
import 'package:pet_feeder/schedule.dart';
import 'package:pet_feeder/src/sample_feature/pet_list_view.dart';

class BottomNavbar extends StatefulWidget {

  const BottomNavbar({super.key});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;
  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> pages = [];

  final _pages = [
    PetListPage(),
    SchedulePage(),
    MyVetMessagingPage(),
  ];

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
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => {
          setState(() => currentIndex = index)
        },
      ),
    );
  }

}
