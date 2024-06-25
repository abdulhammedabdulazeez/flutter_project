import 'package:community_food_app/pages/for_restaurants/restaurant_signup_screen.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_home_wrapper.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_signup_screen.dart';
import 'package:community_food_app/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/shelter_signup_page': (context) => const ShelterSignupScreen(),
        '/shelter_main_page': (context) => const ShelterHomeWrapper(),
        '/restaurant_signup_page': (context) => const RestaurantSignupScreen(),
      },
    ),
  );
}
