// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Measurement {
  // final int id;
  final int userId; // Assuming the user ID from MyUser model
  final double leftArm;
  final double rightArm;
  final double chest;
  final double leftQuadricep;
  final double rightQuadricep;
  final double leftCalve;
  final double rightCalve;
  final double leftForearm;
  final double rightForearm;
  final double waist;
  final double bodyweight;
  final DateTime timestamp;
  Measurement({
    required this.userId,
    required this.leftArm,
    required this.rightArm,
    required this.chest,
    required this.leftQuadricep,
    required this.rightQuadricep,
    required this.leftCalve,
    required this.rightCalve,
    required this.leftForearm,
    required this.rightForearm,
    required this.waist,
    required this.bodyweight,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'leftArm': leftArm,
      'rightArm': rightArm,
      'chest': chest,
      'leftQuadricep': leftQuadricep,
      'rightQuadricep': rightQuadricep,
      'leftCalve': leftCalve,
      'rightCalve': rightCalve,
      'leftForearm': leftForearm,
      'rightForearm': rightForearm,
      'waist': waist,
      'bodyweight': bodyweight,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      userId: map['userId'] as int,
      leftArm: map['leftArm'] as double,
      rightArm: map['rightArm'] as double,
      chest: map['chest'] as double,
      leftQuadricep: map['leftQuadricep'] as double,
      rightQuadricep: map['rightQuadricep'] as double,
      leftCalve: map['leftCalve'] as double,
      rightCalve: map['rightCalve'] as double,
      leftForearm: map['leftForearm'] as double,
      rightForearm: map['rightForearm'] as double,
      waist: map['waist'] as double,
      bodyweight: map['bodyweight'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Measurement.fromJson(String source) =>
      Measurement.fromMap(json.decode(source) as Map<String, dynamic>);
}
