//signup model for dart

class UserModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String username;
  final String password;
  final String activityLevel;
  final int age;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.username,
      required this.password,
      required this.activityLevel,
      required this.age});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      password: json['password'],
      activityLevel: json['activityLevel'],
      age: json['age'],
    );
  }
}
