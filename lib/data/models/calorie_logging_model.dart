class CaloriesLog {
  final String? username;
  final String? food;
  final double? servingSizeConsumed;
  final double? proteinConsumed;
  final double? carbsConsumed;
  final double? fatConsumed;
  final double? caloriesConsumed;

  CaloriesLog({
    this.username,
    this.food,
    this.servingSizeConsumed,
    this.proteinConsumed,
    this.carbsConsumed,
    this.fatConsumed,
    this.caloriesConsumed,
  });

  factory CaloriesLog.fromJson(Map<String, dynamic> json) {
    return CaloriesLog(
      username: json['username'],
      food: json['food'],
      servingSizeConsumed: json['servingSizeConsumed'],
      proteinConsumed: json['proteinConsumed'],
      carbsConsumed: json['carbsConsumed'],
      fatConsumed: json['fatConsumed'],
      caloriesConsumed: json['caloriesConsumed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'food': food,
      'servingSizeConsumed': servingSizeConsumed,
      'proteinConsumed': proteinConsumed,
      'carbsConsumed': carbsConsumed,
      'fatConsumed': fatConsumed,
      'caloriesConsumed': caloriesConsumed,
    };
  }
}
