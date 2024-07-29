import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/food_card.dart';
import 'package:community_food_app/models/food.dart';
import 'package:community_food_app/providers/add_to_bag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailableFoods extends ConsumerStatefulWidget {
  const AvailableFoods(
      {super.key, required this.foodItems, required this.title});

  final List<Food> foodItems;
  final String title;

  @override
  ConsumerState<AvailableFoods> createState() => _AvailableFoodsState();
}


class _AvailableFoodsState extends ConsumerState<AvailableFoods> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.title,
          style: const TextStyle(
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
              children: widget.foodItems.asMap().entries.map((entry) {
                // int index = entry.key;
                Food foodItem = entry.value;

                final addedToBag = ref.watch(addToBagProvider);
                final isAdded = addedToBag.contains(foodItem);

                return FoodCard(
                  imgPath: foodItem.imageUrl,
                  dishName: foodItem.title,
                  restaurant: foodItem.restaurantName,
                  description: foodItem.ingredients.toString(),
                  attachment: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref
                              .read(addToBagProvider.notifier)
                              .toggleAddToBag(foodItem);
                        },
                        icon: Icon(isAdded ? Icons.check_box_outlined: Icons.add_box_outlined),
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
