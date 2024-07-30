import 'dart:io';

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

  TextEditingController nameController = TextEditingController();
  TextEditingController ingrdientsController = TextEditingController();
   

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
    nameController.dispose();
    ingrdientsController.dispose();
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
      });
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
            const Text(
              'Shelter Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 3, 71, 50),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                filled: false,
                // fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Ingredients:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 3, 71, 50),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: ingrdientsController,
              decoration: const InputDecoration(
                filled: false,
                // fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 3, 71, 50),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
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
            const SizedBox(height: 50),
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
                const SizedBox(width: 50),
                IconButton(
                  onPressed: addQuantity,
                  icon: const Icon(
                    Icons.add_circle,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  foodQuantity.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: subtractQuantity,
                  icon: const Icon(
                    Icons.remove_circle,
                    size: 30,
                  ),
                ),
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
              onPressed: () {},
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
