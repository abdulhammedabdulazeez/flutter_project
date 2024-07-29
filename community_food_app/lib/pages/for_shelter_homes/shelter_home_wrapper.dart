import 'package:community_food_app/pages/for_shelter_homes/shelter_cart_screen.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_main_screen.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_support_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShelterHomeWrapper extends StatefulWidget {
  const ShelterHomeWrapper({super.key});

  @override
  State<ShelterHomeWrapper> createState() => _ShelterHomeWrapperState();
}

class _ShelterHomeWrapperState extends State<ShelterHomeWrapper> {
  int _currentIndex = 0;

  // Botton Navigation Icons Items
  final List<BottomNavigationBarItem> _navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      label: 'Bag',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_rounded),
      label: 'Support',
    ),
  ];

  final List pages = const [
    ShelterMainScreen(),
    ShelterCartScreen(),
    ShelterSupportScreen(),
  ];

  // Setting AppBar Dynamically
  final List<Map<String, dynamic>> _setAppBar = [
    {
      'showAppBar': true,
      'leading': Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/appbar_logo.png',
          fit: BoxFit.contain,
        ),
      ),
    },
    {'showAppBar': false},
    {'showAppBar': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _setAppBar[_currentIndex]['showAppBar']
          ? AppBar(
              toolbarHeight: 100,
              leadingWidth: 120,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/appbar_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/notification_page');
                  },
                  icon: const Icon(Icons.notifications_none_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/location_filter_page');
                  },
                  icon: const Icon(Icons.tune_outlined),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/shelter_login_page');
                  },
                  icon: const Icon(Icons.no_accounts),
                ),
              ],
            )
          : null,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 3, 71, 50),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}
