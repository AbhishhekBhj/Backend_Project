import 'dart:convert';

class WaterLog {
  final String? username;
  final dynamic? volume;

  WaterLog({
    this.username,
    this.volume,
  });

  Map<String,dynamic> toMap() {
    return <String,dynamic>{
      'username': username,
      'volume': volume,
    };
  }

  factory WaterLog.fromMap(Map<String,dynamic> map) {
    return WaterLog(
      username: map['username'] as String,
      volume: map['volume'] as dynamic,
    );
  }

  String toJson()=> json.encode(toMap());

  factory WaterLog.fromJson(String source) => WaterLog.fromMap(json.decode(source));
  
}
