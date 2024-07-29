import 'package:community_food_app/providers/add_to_bag_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:community_food_app/models/food.dart';

class FoodItemState {
  final Food food;
  int count;

  FoodItemState(this.food, this.count);
}


class FoodCountNotifier extends StateNotifier<List<FoodItemState>> {
  FoodCountNotifier(List<Food> initialFoodItems)
      : super(initialFoodItems.map((food) => FoodItemState(food, 1)).toList());

  void incrementItemCount(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          FoodItemState(state[i].food, state[i].count + 1)
        else
          state[i]
    ];
  }

  void decrementItemCount(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index && state[i].count > 1)
          FoodItemState(state[i].food, state[i].count - 1)
        else
          state[i]
    ];
  }
}

final foodCountProvider = StateNotifierProvider<FoodCountNotifier, List<FoodItemState>>((ref) {
  final foodList = ref.watch(addToBagProvider);
  return FoodCountNotifier(foodList);
});