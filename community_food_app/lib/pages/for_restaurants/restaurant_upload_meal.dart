import 'dart:io';

import 'package:community_food_app/auth/firebase_auth_implementation/firebase_storage_services.dart';
import 'package:community_food_app/models/category_list_data.dart';
import 'package:community_food_app/models/dummy_data.dart';
import 'package:community_food_app/models/food.dart';
import 'package:community_food_app/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RestaurantUploadMeal extends StatefulWidget {
  const RestaurantUploadMeal({super.key});

  @override
  State<RestaurantUploadMeal> createState() => _RestaurantUploadMealState();
}

class _RestaurantUploadMealState extends State<RestaurantUploadMeal> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  StorageService storage = StorageService();

  String? _selectedRestaurant;
  CategoryItem? _selectedCategory;

  TextEditingController mealController = TextEditingController();
  TextEditingController ingrdientsController = TextEditingController();
  TextEditingController idController = TextEditingController();

  File? selectedImage;

  void _selectTimeRange() async {
    final start = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (start != null && mounted) {
      final end = await showTimePicker(
        context: context,
        initialTime: start.replacing(hour: start.hour + 1),
      );
      if (end != null && mounted) {
        setState(() {
          _startTime = start;
          _endTime = end;
        });
      }
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  @override
  void dispose() {
    mealController.dispose();
    ingrdientsController.dispose();
    idController.dispose();
    super.dispose();
  }

  var foodQuantity = 1;

  void addQuantity() {
    setState(() {
      foodQuantity++;
    });
  }

  void subtractQuantity() {
    if (foodQuantity > 1) {
      setState(() {
        foodQuantity--;
      });
    }
  }


  Future uploadImage() async {
    final uploadedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (uploadedImage != null) {
      setState(() {
        selectedImage = File(uploadedImage.path);
        showToast(message: 'Image uploaded');
      });
    }
    // print(await storage.uploadImageAndGetUrl(selectedImage!));
  }

  void _onClickUpload() async {
    if (_selectedRestaurant != null &&
        _selectedCategory != null &&
        mealController.text.isNotEmpty &&
        ingrdientsController.text.isNotEmpty &&
        selectedImage != null) {

      final imageUrl = await storage.uploadImageAndGetUrl(selectedImage!);

      final newFood = Food(
        id: '',
        title: mealController.text,
        categories: [_selectedCategory!.label],
        catagory: _selectedCategory!.label,
        imageUrl: imageUrl,
        ingredients: ingrdientsController.text.split(',').toList(),
        restaurantName: _selectedRestaurant!,
      );

      // Save to Firestore
      await storage.uploadMeal(newFood);
      await storage.uploadMealToAggregation(newFood);

      // Navigate back or update UI
      if (mounted) {
        showToast(message: 'Meal uploaded successfully');
        Navigator.pop(context);
      }
    } else {
      showToast(message: 'Please fill out all fields.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'Upload',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 3, 71, 50),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: mealController,
              decoration: const InputDecoration(
                hintText: 'Meal Name',
                filled: false,
                // fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                border: UnderlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ingrdientsController,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Ingredients',
                // fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                border: UnderlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedRestaurant,
              hint: const Text('Select Your Restaurant'),
              items: restaurants.map((String restaurant) {
                return DropdownMenuItem<String>(
                  value: restaurant,
                  child: Text(
                    restaurant,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRestaurant = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a restaurant' : null,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<CategoryItem>(
              value: _selectedCategory,
              hint: const Text('Select meal category'),
              items: categories.map((category) {
                return DropdownMenuItem<CategoryItem>(
                  value: category,
                  child: Text(
                    category.label,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a category' : null,
            ),
            const SizedBox(height: 30),
            const Text(
              'Food Image',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                selectedImage != null
                    ? Image.file(
                        selectedImage!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 100,
                      ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    backgroundColor: const Color.fromARGB(255, 241, 143, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    uploadImage();
                  },
                  child: const Text(
                    'Select a file',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text(
                  'Quantity: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                // const SizedBox(width: 5),
                IconButton(
                  onPressed: subtractQuantity,
                  icon: const Icon(
                    Icons.remove_circle,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  foodQuantity.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: addQuantity,
                  icon: const Icon(
                    Icons.add_circle,
                    size: 30,
                  ),
                ),
                
                // ConstrainedBox(
                //   constraints: const BoxConstraints(maxWidth: 150),
                //   child: TextFormField(
                //     controller: idController,
                //     decoration: const InputDecoration(
                //       filled: false,
                //       hintText: 'Input Id',
                //       // fillColor: Colors.white,
                //       contentPadding:
                //           EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         borderSide: BorderSide(
                //           color: Color.fromARGB(255, 3, 71, 50),
                //           width: 1,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         borderSide: BorderSide(
                //           color: Color.fromARGB(255, 3, 71, 50),
                //           width: 1,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 3, 71, 50),
                    ),
                    onPressed: () => _selectTimeRange(),
                    child: Text(_startTime == null
                        ? 'Select Start Time'
                        : 'Start: ${_formatTimeOfDay(_startTime!)}'),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 3, 71, 50),
                    ),
                    onPressed: () => _selectTimeRange(),
                    child: Text(_endTime == null
                        ? 'Select End Time'
                        : 'End: ${_formatTimeOfDay(_endTime!)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 40,
                ),
                backgroundColor: const Color.fromARGB(255, 241, 143, 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _onClickUpload,
              child: const Text(
                'Upload',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
