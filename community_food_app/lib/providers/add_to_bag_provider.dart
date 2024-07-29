import 'package:community_food_app/models/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToBagNotifier extends StateNotifier<List<Food>> {
  AddToBagNotifier() : super([]);

  bool toggleAddToBag(Food food) {
    final foodIsAdded = state.contains(food);

    if (foodIsAdded) {
      state = state.where((f) => f.id != food.id).toList();
      return false;
    } else {
      state = [...state, food];
      return true;
    }
  }
}

final addToBagProvider = StateNotifierProvider<AddToBagNotifier, List<Food>>((ref) {
  return AddToBagNotifier();
});