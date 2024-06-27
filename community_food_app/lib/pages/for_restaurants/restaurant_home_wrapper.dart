import 'package:community_food_app/pages/for_restaurants/restaurant_main_screen.dart';
import 'package:community_food_app/pages/for_restaurants/restaurant_support_screen.dart';
import 'package:flutter/material.dart';

class RestaurantHomeWrapper extends StatefulWidget {
  const RestaurantHomeWrapper({super.key});

  @override
  State<RestaurantHomeWrapper> createState() => _RestaurantHomeWrapperState();
}

class _RestaurantHomeWrapperState extends State<RestaurantHomeWrapper> {
  int _currentIndex = 0;

  // Botton Navigation Icons Items
  final List<BottomNavigationBarItem> _navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_rounded),
      label: 'Support',
    ),
  ];

  final List pages = const [
    RestarantMainScreen(),
    RestaurantSupportScreen(),
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
                    Navigator.pushNamed(context, '/restaurant_notification_page');
                  },
                  icon: const Icon(Icons.notifications_none_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/restaurant_filter_page');
                  },
                  icon: const Icon(Icons.tune_outlined),
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
