import 'package:flutter/material.dart';
import 'package:community_food_app/models/category_list_data.dart';

class ShelterMainScreen extends StatefulWidget {
  const ShelterMainScreen({super.key});

  @override
  State<ShelterMainScreen> createState() => _ShelterMainScreenState();
}

class _ShelterMainScreenState extends State<ShelterMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories of foods',
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 3, 71, 50),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final categoryItem = categories[index];
                return InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    color: const Color.fromARGB(255, 233, 140, 1),
                    shadowColor: const Color.fromARGB(255, 134, 229, 171),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categoryItem.icon,
                          size: 50,
                          color: const Color.fromARGB(255, 3, 71, 50),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          categoryItem.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
