class FoodItem {
  final String userId;
  final String foodName;
  final String? foodImage;
  final String foodDescription;
  final double foodCaloriesPerServing;
  final double foodServingSize;
  final double foodProteinPerServing;
  final double foodCarbsPerServing;
  final double foodFatPerServing;

  FoodItem({
    required this.userId,
    required this.foodName,
    this.foodImage,
    required this.foodDescription,
    required this.foodCaloriesPerServing,
    required this.foodServingSize,
    required this.foodProteinPerServing,
    required this.foodCarbsPerServing,
    required this.foodFatPerServing,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      userId: json['user_id'],
      foodName: json['food_name'],
      foodImage: json['food_image'],
      foodDescription: json['food_description'],
      foodCaloriesPerServing: json['food_calories_per_serving'].toDouble(),
      foodServingSize: json['food_serving_size'].toDouble(),
      foodProteinPerServing: json['food_protein_per_serving'].toDouble(),
      foodCarbsPerServing: json['food_carbs_per_serving'].toDouble(),
      foodFatPerServing: json['food_fat_per_serving'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'food_name': foodName,
      'food_image': foodImage,
      'food_description': foodDescription,
      'food_calories_per_serving': foodCaloriesPerServing,
      'food_serving_size': foodServingSize,
      'food_protein_per_serving': foodProteinPerServing,
      'food_carbs_per_serving': foodCarbsPerServing,
      'food_fat_per_serving': foodFatPerServing,
    };
  }
}
