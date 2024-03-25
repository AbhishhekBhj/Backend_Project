import 'dart:convert';

class BodyMeasurement {
  final String? measurementId; // Make measurementId optional
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
  final String? createdAt;

  BodyMeasurement({
    this.measurementId,
    required this.height,
    required this.weight,
    required this.chestSize,
    required this.waistSize,
    required this.hipSize,
    required this.leftArm,
    required this.rightArm,
    required this.user,
    required this.leftQuadricep,
    required this.rightQuadricep,
    required this.leftCalf,
    required this.rightCalf,
    required this.leftForearm,
    required this.rightForearm,
    required this.notes,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (measurementId != null) 'measurementId': measurementId,
      'height': height,
      'weight': weight,
      'chestSize': chestSize,
      'waistSize': waistSize,
      'hipSize': hipSize,
      'leftArm': leftArm,
      'rightArm': rightArm,
      'user': user,
      'leftQuadricep': leftQuadricep,
      'rightQuadricep': rightQuadricep,
      'leftCalf': leftCalf,
      'rightCalf': rightCalf,
      'leftForearm': leftForearm,
      'rightForearm': rightForearm,
      'notes': notes,
    };
  }

  factory BodyMeasurement.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return BodyMeasurement(
      measurementId: map['measurement_id'] as String?,
      height: map['height'] as double,
      weight: map['weight'] as double,
      chestSize: map['chest_size'] as double,
      waistSize: map['waist_size'] as double,
      hipSize: map['hip_size'] as double,
      leftArm: map['left_arm'] as double,
      rightArm: map['right_arm'] as double,
      user: map['user'] as int,
      leftQuadricep: map['left_quadricep'] as double,
      rightQuadricep: map['right_quadricep'] as double,
      leftCalf: map['left_calf'] as double,
      rightCalf: map['right_calf'] as double,
      leftForearm: map['left_forearm'] as double,
      rightForearm: map['right_forearm'] as double,
      notes: map['notes'] as String,
      createdAt: map['created_at'] as String?,
    );
  }

  String toJson() => json.encode(toMap());
}
