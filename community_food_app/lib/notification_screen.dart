import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
