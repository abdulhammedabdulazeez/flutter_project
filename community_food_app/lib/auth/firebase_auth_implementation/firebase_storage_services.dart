import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_food_app/models/food.dart';
import 'package:community_food_app/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  // final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth user = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> uploadImageAndGetUrl(File imageFile) async {
  final storageRef = FirebaseStorage.instance.ref().child('meal_images/${DateTime.now().toIso8601String()}');

    // Upload image
    final uploadTask = storageRef.putFile(imageFile);

    // Get the download URL
    final snapshot = await uploadTask;
    final imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }
  
  Future<void> uploadMeal(Food meal) async {
    // Get the current user
    User? currentUser = user.currentUser;
    
    if (currentUser == null) {
      showToast(message: 'No authenticated user found');
    }

    // Use the user's ID to get the specific restaurant's collection
    final mealRef = db
        .collection('restaurants')
        .doc(currentUser!.uid) // This is the restaurant ID
        .collection('meals')
        .doc(); // Auto-ID for meal

    
    await mealRef.set({
      "id": mealRef.id,
      'name': meal.title,
      'category': meal.catagory,
      'imageUrl': meal.imageUrl,
      'ingredients': meal.ingredients,
      'restaurantName':meal.restaurantName
      // Add other fields as needed
    });
  }

  Future<void> uploadMealToAggregation(Food meal) async {
    final mealRef = db.collection('meals').doc();

    await mealRef.set({
      'restaurantId': user.currentUser!.uid,
      "id": mealRef.id,
      'name': meal.title,
      'category': meal.catagory,
      'imageUrl': meal.imageUrl,
      'ingredients': meal.ingredients,
      'restaurantName':meal.restaurantName
      // Add other fields as needed
    });
  }


}