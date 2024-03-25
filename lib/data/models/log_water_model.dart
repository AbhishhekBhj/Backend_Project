import 'dart:convert';

class WaterLog {
  final int? username;
  final double? volume;

  WaterLog({
    this.username,
    this.volume,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'volume': volume,
    };
  }

  factory WaterLog.fromJson(Map<String, dynamic> json) {
    return WaterLog(
      username: json['username'],
      volume: json['volume'].toDouble(),
    );
  }

  factory WaterLog.fromMap(Map<String, dynamic> map) {
    return WaterLog(
      username: map['username'] as int,
      volume: map['volume'] as double,
    );
  }

  String toJson() => json.encode(toMap());
}
