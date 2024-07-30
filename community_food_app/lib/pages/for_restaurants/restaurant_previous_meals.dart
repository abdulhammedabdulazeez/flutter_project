import 'package:community_food_app/food_card.dart';
import 'package:community_food_app/pages/for_restaurants/restaurant_upload_meal.dart';
import 'package:flutter/material.dart';

class RestarantPreviousMeal extends StatefulWidget {
  const RestarantPreviousMeal({super.key});

  @override
  State<RestarantPreviousMeal> createState() => _RestarantPreviousMealState();
}

class _RestarantPreviousMealState extends State<RestarantPreviousMeal> {
  final List<Map<String, dynamic>> foodItems = [
    {
      'imagePath': 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Grilled_salmon.jpg',
      'name': 'Leafy Green Salad',
      'desp':
          'Pams baby spinach, galaxy creamy feta, pams strawberries, sliced almonds, blue cheese',
      'selected': false,
    },
    {
      'imagePath': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Stir_Fried_Watercress.jpg/2560px-Stir_Fried_Watercress.jpg?20190131173852',
      'name': 'Bound Salad',
      'desp': 'Avocado, corn, pepperjack, crispy shallots, romaine',
      'selected': false,
    },
    {
      'imagePath': 'https://upload.wikimedia.org/wikipedia/commons/4/4b/Prawn_cocktail.jpg',
      'name': 'Garden Salad',
      'desp': 'Chopt lettuce blend, blue cheese, grape tomatoes, romaine',
      'selected': false,
    },
    {
      'imagePath': 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Veggie_platter.jpg?20170131184741',
      'name': 'Fattoush',
      'desp':
          'Gluten-sensitive noodle stir-fry with shrimp, egg, citrus, peanuts, green onions.',
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
          'Previous Meals Recorded',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 3, 71, 50),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const RestaurantUploadMeal())
          );
        },
        backgroundColor: const Color.fromARGB(255, 48, 230, 172),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: foodItems.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> foodItem = entry.value;

                return FoodCard(
                  imgPath: foodItem['imagePath'],
                  restaurant: '',
                  dishName: foodItem['name'],
                  description: foodItem['desp'],
                  attachment: Row(
                    children: [
                      IconButton(
                        onPressed: () => onClick(index),
                        icon: const Icon(
                          Icons.highlight_remove_rounded,
                        ),
                        color: const Color.fromARGB(255, 3, 71, 50),
                      )
                    ],
                  ), 
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
