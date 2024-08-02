import 'package:community_food_app/food_card.dart';
import 'package:community_food_app/models/food.dart';
import 'package:community_food_app/pages/for_restaurants/restaurant_upload_meal.dart';
import 'package:flutter/material.dart';

class RestarantPreviousMeal extends StatefulWidget {
  const RestarantPreviousMeal({super.key, required this.foodItems});

  final List<Food> foodItems;

  @override
  State<RestarantPreviousMeal> createState() => _RestarantPreviousMealState();
}

class _RestarantPreviousMealState extends State<RestarantPreviousMeal> {

  void onClick(int index) {
    setState(() {
      // widget.foodItems[index]['selected'] = !foodItems[index]['selected'];
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
              children: widget.foodItems.asMap().entries.map((entry) {
                int index = entry.key;
                Food foodItem = entry.value;

                return FoodCard(
                  imgPath: foodItem.imageUrl,
                  restaurant: foodItem.restaurantName,
                  dishName: foodItem.title,
                  description: foodItem.ingredients.toString(),
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
