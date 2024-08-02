import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/food_card.dart';
import 'package:community_food_app/models/category_list_data.dart';
import 'package:community_food_app/models/food.dart';
import 'package:community_food_app/providers/add_to_bag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailableFoods extends ConsumerStatefulWidget {
  const AvailableFoods(
      {super.key, required this.category});

  // final List<Food> foodItems;
  final CategoryItem category;

  @override
  ConsumerState<AvailableFoods> createState() => _AvailableFoodsState();
}


class _AvailableFoodsState extends ConsumerState<AvailableFoods> {

  // final List<Food> foodItems =[];

  Stream<List<Food>> getAllMealsStream() {
    return FirebaseFirestore.instance.collection('meals').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Food(
          id: doc.id,
          title: data['name'],
          categories: List<String>.from([data['category']]),
          imageUrl: data['imageUrl'],
          ingredients: List<String>.from(data['ingredients']),
          restaurantName: data['restaurantName'],
          // category: data['category'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final addToBag = ref.watch(addToBagProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.category.label,
          style: const TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 3, 71, 50),
          ),
        ),
      ),
      body: StreamBuilder<List<Food>>(
        stream: getAllMealsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final foodItems = snapshot.data;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Column(
                  children: foodItems!
                      .where((foodItem) => foodItem.categories.contains(widget.category.label))
                      .map((foodItem) {
                    final isAdded = addToBag.contains(foodItem);

                    return FoodCard(
                      imgPath: foodItem.imageUrl,
                      dishName: foodItem.title,
                      restaurant: foodItem.restaurantName,
                      description: foodItem.ingredients.toString(),
                      attachment: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ref.read(addToBagProvider.notifier).toggleAddToBag(foodItem);
                            },
                            icon: Icon(isAdded ? Icons.check_box_outlined : Icons.add_box_outlined),
                            color: const Color.fromARGB(255, 3, 71, 50),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ButtonComponent(
                  text: 'Done!',
                  onTap: () {
                    // Implement the functionality for the Done button
                  },
                  textColor: 'black',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {

  //   return Scaffold(
  //     appBar: AppBar(
  //       toolbarHeight: 100,
  //       title: Text(
  //         widget.category.label,
  //         style: const TextStyle(
  //           fontSize: 25,
  //           color: Color.fromARGB(255, 3, 71, 50),
  //         ),
  //       ),
  //     ),
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
  //       child: Column(
  //         children: [
  //           const SizedBox(height: 20),
  //           Column(
  //             children: foodItems.asMap().entries.map((entry) {
  //               // int index = entry.key;
  //               Food foodItem = entry.value;

  //               final addedToBag = ref.watch(addToBagProvider);
  //               final isAdded = addedToBag.contains(foodItem);

  //               return FoodCard(
  //                 imgPath: foodItem.imageUrl,
  //                 dishName: foodItem.title,
  //                 restaurant: foodItem.restaurantName,
  //                 description: foodItem.ingredients.toString(),
  //                 attachment: Row(
  //                   children: [
  //                     IconButton(
  //                       onPressed: () {
  //                         ref
  //                             .read(addToBagProvider.notifier)
  //                             .toggleAddToBag(foodItem);
  //                       },
  //                       icon: Icon(isAdded ? Icons.check_box_outlined: Icons.add_box_outlined),
  //                       color: const Color.fromARGB(255, 3, 71, 50),
  //                     )
  //                   ],
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //           const SizedBox(height: 20),
  //           ButtonComponent(
  //             text: 'Done!',
  //             onTap: () {},
  //             textColor: 'black',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
