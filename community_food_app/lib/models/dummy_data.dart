import 'package:community_food_app/models/category_list_data.dart';
import 'package:community_food_app/models/food.dart';
import 'package:flutter/material.dart';

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

final List<String> restaurants = [
    'Afrinaija Pots Restaurant',
    'Vista-Kigali Resto Bar _Bumbogo',
    'Repub Lounge',
    'Inka Steakhouse',
    'Nyurah'
  ];

List<Food> dummyMeals = [
  Food(
    id: 'm1',
    title: 'Grilled Salmon',
    categories: ['seafoods'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Grilled_salmon.jpg',
    ingredients: [
      'Salmon',
      'Olive Oil',
      'Garlic',
      'Lemon',
      'Salt',
      'Pepper'
    ],
    restaurantName: 'Afrinaija Pots Restaurant'
  ),
  Food(
    id: 'm2',
    title: 'Fruit Salad',
    categories: ['fruits', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/74/Fruktsallad_%28Fruit_salad%29.jpg',
    ingredients: [
      'Apple',
      'Banana',
      'Strawberry',
      'Grapes',
      'Orange',
      'Mint'
    ],
    restaurantName: 'Vista-Kigali Resto Bar _Bumbogo'
  ),
  Food(
    id: 'm3',
    title: 'Vegetable Stir-fry',
    categories: ['vegetables'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Stir_Fried_Watercress.jpg/2560px-Stir_Fried_Watercress.jpg?20190131173852',
    ingredients: [
      'Broccoli',
      'Carrot',
      'Bell Pepper',
      'Soy Sauce',
      'Ginger',
      'Garlic'
    ],
    restaurantName: 'Repub Lounge'
  ),
  Food(
    id: 'm4',
    title: 'Shrimp Cocktail',
    categories: ['seafoods', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/4b/Prawn_cocktail.jpg',
    ingredients: [
      'Shrimp',
      'Cocktail Sauce',
      'Lemon',
      'Parsley'
    ],
    restaurantName: 'Inka Steakhouse'
  ),
  Food(
    id: 'm5',
    title: 'Veggie Platter',
    categories: ['vegetables', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/d/d0/Veggie_platter.jpg?20170131184741',
    ingredients: [
      'Carrot Sticks',
      'Celery Sticks',
      'Cherry Tomatoes',
      'Cucumber Slices',
      'Hummus'
    ],
    restaurantName: 'Nyurah'
  ),
  Food(
    id: 'm6',
    title: 'Fruit Smoothie',
    categories: ['fruits', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Fruit_smoothie_%288475314736%29.png/729px-Fruit_smoothie_%288475314736%29.png?20200228105827',
    ingredients: [
      'Banana',
      'Strawberries',
      'Yogurt',
      'Honey',
      'Orange Juice'
    ],
    restaurantName: 'Afrinaija Pots Restaurant'

  ),
  Food(
    id: 'm7',
    title: 'Grilled Vegetable Skewers',
    categories: ['vegetables', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Veggie_Skewers.jpg/1600px-Veggie_Skewers.jpg?20131107191035',
    ingredients: [
      'Bell Peppers',
      'Zucchini',
      'Red Onion',
      'Cherry Tomatoes',
      'Olive Oil',
      'Salt',
      'Pepper'
    ],
    restaurantName: 'Vista-Kigali Resto Bar _Bumbogo'
  ),
  Food(
    id: 'm8',
    title: 'Mango Salsa',
    categories: ['fruits', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Mango_salsa.jpg/1543px-Mango_salsa.jpg?20230826124313',
    ingredients: [
      'Mango',
      'Red Onion',
      'Cilantro',
      'Lime Juice',
      'Jalapeno',
      'Salt'
    ],
    restaurantName: 'Repub Lounge'
  ),
  Food(
    id: 'm9',
    title: 'Caesar Salad',
    categories: ['vegetables'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Caesar_salad_%281%29.jpg/1600px-Caesar_salad_%281%29.jpg?20140909092135',
    ingredients: [
      'Romaine Lettuce',
      'Croutons',
      'Caesar Dressing',
      'Parmesan Cheese'
    ],
    restaurantName: 'Inka Steakhouse'
  ),
  Food(
    id: 'm10',
    title: 'Tuna Sushi',
    categories: ['seafoods', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Kindai_Tuna_Sushi.jpg/1599px-Kindai_Tuna_Sushi.jpg?20220820052941',
    ingredients: [
      'Tuna',
      'Sushi Rice',
      'Nori',
      'Soy Sauce',
      'Wasabi',
      'Pickled Ginger'
    ],
    restaurantName: 'Nyurah'
  ),
  Food(
    id: 'm11',
    title: 'Berry Parfait',
    categories: ['fruits', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/2/20/Parfait_de_Frutos_Rojos.jpg',
    ingredients: [
      'Blueberries',
      'Strawberries',
      'Yogurt',
      'Granola',
      'Honey'
    ],
    restaurantName: 'Afrinaija Pots Restaurant'
  ),
  Food(
    id: 'm12',
    title: 'Stuffed Bell Peppers',
    categories: ['vegetables'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flickr_-_cyclonebill_-_Peberfrugt_farseret_med_tigerrejer.jpg/2560px-Flickr_-_cyclonebill_-_Peberfrugt_farseret_med_tigerrejer.jpg',
    ingredients: [
      'Bell Peppers',
      'Ground Beef',
      'Rice',
      'Tomato Sauce',
      'Cheese',
      'Onion'
    ],
    restaurantName: 'Vista-Kigali Resto Bar _Bumbogo'
  ),
  Food(
    id: 'm13',
    title: 'Avocado Toast',
    categories: ['vegetables', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/2014_avocado_salad_tomato_salsa_toasted_baguette.jpg/1280px-2014_avocado_salad_tomato_salsa_toasted_baguette.jpg',
    ingredients: [
      'Bread',
      'Avocado',
      'Lemon Juice',
      'Salt',
      'Pepper',
      'Olive Oil'
    ],
    restaurantName: 'Repub Lounge'
  ),
  Food(
    id: 'm14',
    title: 'Prawn Cocktail',
    categories: ['seafoods'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Anna%27s_Seafood_-_December_2023_-_Sarah_Stierch.jpg/2560px-Anna%27s_Seafood_-_December_2023_-_Sarah_Stierch.jpg',
    ingredients: [
      'Prawns',
      'Cocktail Sauce',
      'Lettuce',
      'Lemon'
    ],
    restaurantName: 'Inka Steakhouse'
  ),
  Food(
    id: 'm15',
    title: 'Cucumber Sandwiches',
    categories: ['vegetables', 'snacks'],
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Cucumber_sandwiches_%288768307255%29.jpg/900px-Cucumber_sandwiches_%288768307255%29.jpg?20140828201939',
    ingredients: [
      'Bread',
      'Cucumber',
      'Cream Cheese',
      'Dill',
      'Salt',
      'Pepper'
    ],
    restaurantName: 'Nyurah'
  ),
];