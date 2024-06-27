import 'package:flutter/material.dart';

class RestaurantNotificatioScreen extends StatefulWidget {
  const RestaurantNotificatioScreen({super.key});

  @override
  State<RestaurantNotificatioScreen> createState() => _RestaurantNotificatioScreenState();
}

class _RestaurantNotificatioScreenState extends State<RestaurantNotificatioScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notification',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 3, 71, 50),
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'No Notifications',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 3, 71, 50),
            ),
          ),
        ),
      ),
    );
  }
}