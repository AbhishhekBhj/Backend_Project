class CaloriesLog {
  final double caloriesConsumed;
  final double servingConsumed;
  final double proteinConsumed;
  final double carbsConsumed;
  final double fatsConsumed;
  final DateTime timestamp;

  final int username;
  final int foodConsumed;

  CaloriesLog({
    required this.caloriesConsumed,
    required this.servingConsumed,
    required this.proteinConsumed,
    required this.carbsConsumed,
    required this.fatsConsumed,
    required this.timestamp,
    required this.username,
    required this.foodConsumed,
  });

  factory CaloriesLog.fromJson(Map<String, dynamic> json) {
    return CaloriesLog(
      caloriesConsumed: json['data']['calories_consumed'],
      servingConsumed: json['data']['serving_consumed'],
      proteinConsumed: json['data']['protein_consumed'],
      carbsConsumed: json['data']['carbs_consumed'],
      fatsConsumed: json['data']['fats_consumed'],
      timestamp: DateTime.parse(json['data']['timestamp']),
      username: json['data']['username'],
      foodConsumed: json['data']['food_consumed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories_consumed': caloriesConsumed,
      'serving_consumed': servingConsumed,
      'protein_consumed': proteinConsumed,
      'carbs_consumed': carbsConsumed,
      'fats_consumed': fatsConsumed,
      'timestamp': timestamp.toIso8601String(),
      'username': username,
      'food_consumed': foodConsumed,
    };
  }
}
