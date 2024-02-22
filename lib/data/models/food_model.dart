class FoodModel {
  final int id;
  final String foodName;
  final String? foodImage;
  final String? foodDescription;
  final double? foodCaloriesPerServing;
  final double? foodServingSize;
  final double? foodProteinPerServing;
  final double? foodCarbsPerServing;
  final double? foodFatPerServing;
  bool fromCache = false;

  FoodModel({
    required this.id,
    required this.foodName,
    this.foodImage,
    required this.foodDescription,
    required this.foodCaloriesPerServing,
    required this.foodServingSize,
    required this.foodProteinPerServing,
    required this.foodCarbsPerServing,
    required this.foodFatPerServing,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
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
      'id': id,
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

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      foodName: map['food_name'],
      foodImage: map['food_image'],
      foodDescription: map['food_description'],
      foodCaloriesPerServing: map['food_calories_per_serving'].toDouble(),
      foodServingSize: map['food_serving_size'].toDouble(),
      foodProteinPerServing: map['food_protein_per_serving'].toDouble(),
      foodCarbsPerServing: map['food_carbs_per_serving'].toDouble(),
      foodFatPerServing: map['food_fat_per_serving'].toDouble(),
    );
  }
}
