class UserProfile {
  int userId;
  String name;
  String username;
  int age;
  String email;
  String fitnessLevel;
  bool isProMember;
  String fitnessGoal;
  String profilePicture;

  UserProfile({
    required this.userId,
    required this.name,
    required this.username,
    required this.age,
    required this.email,
    required this.fitnessLevel,
    required this.isProMember,
    required this.fitnessGoal,
    required this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'],
      name: json['name'],
      username: json['username'],
      age: json['age'],
      email: json['email'],
      fitnessLevel: json['fitness_level'],
      isProMember: json['is_pro_member'],
      fitnessGoal: json['fitness_goal'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'username': username,
      'age': age,
      'email': email,
      'fitness_level': fitnessLevel,
      'is_pro_member': isProMember,
      'fitness_goal': fitnessGoal,
      'profile_picture': profilePicture,
    };
  }
}
