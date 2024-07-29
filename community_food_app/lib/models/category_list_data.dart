import 'package:flutter/material.dart';

enum Category { vegetables, fruits, seafoods, snacks }

class CategoryItem {
  CategoryItem(
      {required this.category, required this.icon, required this.label});

  final Category category;
  final IconData icon;
  final String label;
}

