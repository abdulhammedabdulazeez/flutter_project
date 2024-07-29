import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/food_card.dart';
import 'package:community_food_app/models/food.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_checkout_screen.dart';
import 'package:community_food_app/providers/add_to_bag_provider.dart';
import 'package:community_food_app/providers/item_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShelterCartScreen extends ConsumerStatefulWidget {
  const ShelterCartScreen({super.key});

  // final List<Food> foodItems;

  @override
  ConsumerState<ShelterCartScreen> createState() => _ShelterCartScreenState();
}

class _ShelterCartScreenState extends ConsumerState<ShelterCartScreen> {

  @override
  Widget build(BuildContext context) {

    final foodItems = ref.watch(addToBagProvider);
    final foodCount = ref.watch(foodCountProvider);

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
                Food foodItem = entry.value;

                return FoodCard(
                  imgPath: foodItem.imageUrl,
                  dishName: foodItem.title,
                  restaurant: foodItem.restaurantName,
                  description: foodItem.ingredients.toString(),
                  attachment: Row(
                    children: [
                      const Text('Qty:'),
                      IconButton(
                        onPressed: () {
                          ref.read(foodCountProvider.notifier).incrementItemCount(index);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      Text(foodCount[index].count.toString()),
                      IconButton(
                        onPressed: () {
                          ref.read(foodCountProvider.notifier).decrementItemCount(index);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ButtonComponent(
              text: 'Checkout',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const ShelterCheckoutScreen())
                );
              },
              textColor: 'black',
            ),
          ],
        ),
      ),
    );
  }
}
