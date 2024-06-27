import 'package:community_food_app/notification_screen.dart';
import 'package:community_food_app/pages/for_restaurants/restaurant_signup_screen.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_available_foods.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_home_wrapper.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_location_filter.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_login_screen.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_signup_screen.dart';
import 'package:community_food_app/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/shelter_signup_page': (context) => const ShelterSignupScreen(),
        '/shelter_main_page': (context) => const ShelterHomeWrapper(),
        '/restaurant_signup_page': (context) => const RestaurantSignupScreen(),
        '/notification_page': (context) => const NotificationScreen(),
        '/location_filter_page': (context) => const LocationFilter(),
        '/available_foods_page': (context) => const AvailableFoods(),
        '/shelter_login_page': (context) => const ShelterLoginPage(),
      },
    ),
  );
}
