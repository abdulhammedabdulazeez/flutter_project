import 'package:flutter/material.dart';

enum Category { vegetables, fruits, seafoods, snacks }

class CategoryItem {
  CategoryItem(
      {required this.category, required this.icon, required this.label});

  final Category category;
  final IconData icon;
  final String label;
}

// List of categories with their respective icons and labels
final List<CategoryItem> categories = [
  CategoryItem(
    category: Category.vegetables,
    icon: Icons.local_florist,
    label: 'Vegetables',
  ),
  CategoryItem(
    category: Category.fruits,
    icon: Icons.local_pizza,
    label: 'Fruits',
  ),
  CategoryItem(
    category: Category.seafoods,
    icon: Icons.local_dining,
    label: 'Seafoods',
  ),
  CategoryItem(
    category: Category.snacks,
    icon: Icons.fastfood,
    label: 'Snacks',
  ),
];
