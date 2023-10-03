// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BMIModel {
  final double heightInMetre;
  final double weightInKg;

  BMIModel({required this.heightInMetre, required this.weightInKg});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'heightInMetre': heightInMetre,
      'weightInKg': weightInKg,
    };
  }

  factory BMIModel.fromMap(Map<String, dynamic> map) {
    return BMIModel(
      heightInMetre: map['heightInMetre'] as double,
      weightInKg: map['weightInKg'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory BMIModel.fromJson(String source) =>
      BMIModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
