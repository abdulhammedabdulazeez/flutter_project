import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_food_app/models/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = FutureProvider<List<Food>>((ref) async {
  final querySnapshot = await FirebaseFirestore.instance.collection('meals').get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data();
    return Food(
      id: doc.id,
      title: data['name'],
      categories: List<String>.from(data['category']),
      imageUrl: data['imageUrl'],
      ingredients: List<String>.from(data['ingredients']),
      restaurantName: data['restaurantName'],
    );
  }).toList();
});
