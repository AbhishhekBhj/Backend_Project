import 'dart:convert';

class BodyMeasurement {
  final double height;
  final double weight;
  final double chestSize;
  final double waistSize;
  final double hipSize;
  final double leftArm;
  final double rightArm;
  final int user;

  final double leftQuadricep;
  final double rightQuadricep;
  final double leftCalf;
  final double rightCalf;
  final double leftForearm;
  final double rightForearm;
  final String notes;

  BodyMeasurement({
    required this.height,
    required this.weight,
    required this.chestSize,
    required this.waistSize,
    required this.hipSize,
    required this.leftArm,
    required this.rightArm,
    required this.leftQuadricep,
    required this.rightQuadricep,
    required this.leftCalf,
    required this.rightCalf,
    required this.leftForearm,
    required this.rightForearm,
    required this.notes,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'height': height,
      'weight': weight,
      'chestSize': chestSize,
      'waistSize': waistSize,
      'hipSize': hipSize,
      'leftArm': leftArm,
      'rightArm': rightArm,
      'leftQuadricep': leftQuadricep,
      'rightQuadricep': rightQuadricep,
      'leftCalf': leftCalf,
      'rightCalf': rightCalf,
      'leftForearm': leftForearm,
      'rightForearm': rightForearm,
      'notes': notes,
      'user': user,
    };
  }

  factory BodyMeasurement.fromMap(Map<String, dynamic> map) {
    return BodyMeasurement(
      user: map['id'] as int,
      height: map['height'] as double,
      weight: map['weight'] as double,
      chestSize: map['chest_size'] as double,
      waistSize: map['waist_size'] as double,
      hipSize: map['hip_size'] as double,
      leftArm: map['left_arm'] as double,
      rightArm: map['right_arm'] as double,
      leftQuadricep: map['left_quadricep'] as double,
      rightQuadricep: map['right_quadricep'] as double,
      leftCalf: map['left_calf'] as double,
      rightCalf: map['right_calf'] as double,
      leftForearm: map['left_forearm'] as double,
      rightForearm: map['right_forearm'] as double,
      notes: map['notes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BodyMeasurement.fromJson(String source) =>
      BodyMeasurement.fromMap(json.decode(source) as Map<String, dynamic>);
}
