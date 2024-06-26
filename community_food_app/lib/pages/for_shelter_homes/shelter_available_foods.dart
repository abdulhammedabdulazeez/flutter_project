import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/food_card.dart';
import 'package:flutter/material.dart';

class AvailableFoods extends StatefulWidget {
  const AvailableFoods({super.key});

  @override
  State<AvailableFoods> createState() => _AvailableFoodsState();
}

class _AvailableFoodsState extends State<AvailableFoods> {
  final List<Map<String, dynamic>> foodItems = [
    {
      'imagePath': 'assets/images/Leafy green salad.png',
      'name': 'Leafy Green Salad',
      'desp':
          'Pams baby spinach, galaxy creamy feta, pams strawberries, sliced almonds, blue cheese',
      'selected': false,
    },
    {
      'imagePath': 'assets/images/image salad.png',
      'name': 'Bound Salad',
      'desp': 'Avocado, corn, pepperjack, crispy shallots, romaine',
      'selected': false,
    },
    {
      'imagePath': 'assets/images/Garden salad.png',
      'name': 'Garden Salad',
      'desp': 'Chopt lettuce blend, blue cheese, grape tomatoes, romaine',
      'selected': false,
    },
    {
      'imagePath': 'assets/images/fattoush.png',
      'name': 'Fattoush',
      'desp': 'Gluten-sensitive noodle stir-fry with shrimp, egg, citrus, peanuts, green onions.',
      'selected': false,
    },
  ];

  void onClick(int index) {
    setState(() {
      foodItems[index]['selected'] = !foodItems[index]['selected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'List of Available foods',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 3, 71, 50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
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
                      IconButton(
                        onPressed: () => onClick(index),
                        icon: !foodItem['selected']
                            ? const Icon(
                                Icons.add_box_outlined,
                              )
                            : const Icon(Icons.check_box_outlined),
                        color: const Color.fromARGB(255, 3, 71, 50),
                      )
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
