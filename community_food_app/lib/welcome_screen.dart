import 'package:community_food_app/button_component.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background_image.png'),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(221, 100, 227, 151),
              Color.fromARGB(171, 100, 227, 151),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                ),
                const SizedBox(
                  height: 100,
                ),
                ButtonComponent(
                  text: 'Sign up as a Shelter',
                  onTap: () {
                    Navigator.pushNamed(context, '/shelter_signup_page');
                  },
                  textColor: 'white',
                ),
                const SizedBox(
                  height: 15,
                ),
                ButtonComponent(
                  text: 'Sign up as a Restaurant',
                  onTap: () {
                    Navigator.pushNamed(context, '/restaurant_signup_page');
                  },
                  textColor: 'white',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
