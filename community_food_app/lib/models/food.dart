class Food {
  Food({
    required this.categories,
    required this.id,
    required this.imageUrl,
    required this.ingredients,
    required this.title,
    required this.restaurantName
  });

  final String id;
  final String title;
  final List<String> categories;
  final String imageUrl;
  final List<String> ingredients;
  final String restaurantName;
}
