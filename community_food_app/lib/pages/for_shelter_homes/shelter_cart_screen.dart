import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/food_card.dart';
import 'package:flutter/material.dart';

class ShelterCartScreen extends StatefulWidget {
  const ShelterCartScreen({super.key});

  @override
  State<ShelterCartScreen> createState() => _ShelterCartScreenState();
}

class _ShelterCartScreenState extends State<ShelterCartScreen> {
  final List<Map<String, dynamic>> foodItems = [
    {
      'imagePath': 'assets/images/Leafy green salad.png',
      'name': 'Leafy Green Salad',
      'desp':
          'Pams baby spinach, galaxy creamy feta, pams strawberries, sliced almonds, blue cheese',
      'itemCount': 1,
    },
    {
      'imagePath': 'assets/images/image salad.png',
      'name': 'Bound Salad',
      'desp': 'Avocado, corn, pepperjack, crispy shallots, romaine',
      'itemCount': 1,
    },
  ];

  void incrementItemCount(int index) {
    setState(() {
      foodItems[index]['itemCount']++;
    });
  }

  void decrementItemCount(int index) {
    setState(() {
      if (foodItems[index]['itemCount'] > 1) {
        foodItems[index]['itemCount']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            const Text(
              'Bag',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 3, 71, 50),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'List of Items in bag',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 3, 71, 50),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: foodItems.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> foodItem = entry.value;

                return FoodCard(
                  imgPath: foodItem['imagePath'],
                  dishName: foodItem['name'],
                  description: foodItem['desp'],
                  attachment: Row(
                    children: [
                      const Text('Qty:'),
                      IconButton(
                        onPressed: () => incrementItemCount(index),
                        icon: const Icon(Icons.add),
                      ),
                      Text(foodItem['itemCount'].toString()),
                      IconButton(
                        onPressed: () => decrementItemCount(index),
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ButtonComponent(
              text: 'Done!',
              onTap: () {},
              textColor: 'black',
            ),
          ],
        ),
      ),
    );
  }
}
