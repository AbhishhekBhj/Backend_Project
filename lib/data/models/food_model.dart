// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//model for food items received from the api
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
    return <String, dynamic>{
      'name': name,
      'description': description,
      'caloriesPerServing': caloriesPerServing,
      'servingSize': servingSize,
      'proteinPerServing': proteinPerServing,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'] as String,
      description: map['description'] as String,
      caloriesPerServing: map['caloriesPerServing'] as double,
      servingSize: map['servingSize'] as double,
      proteinPerServing: map['proteinPerServing'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
