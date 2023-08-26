class FoodModel {
  final String? name;
  final String? description;
  final double? caloriesPerServing;
  final double? servingSize;
  final double? proteinPerServing;

  FoodModel({
    this.name,
    this.description,
    this.caloriesPerServing,
    this.servingSize,
    this.proteinPerServing,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'caloriesPerServing': caloriesPerServing,
      'servingSize': servingSize,
      'proteinPerServing': proteinPerServing,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'],
      description: map['description'],
      caloriesPerServing: map['calorie_count_per_serving'],
      servingSize: map['grams_per_serving'],
      proteinPerServing: map['protein_per_serving'],
    );
  }
}
