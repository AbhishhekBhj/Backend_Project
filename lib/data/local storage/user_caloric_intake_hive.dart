import 'package:hive/hive.dart';

class UserCaloricIntakeHive {
  static const String boxName = "userCaloricIntake";

  static const String key = "caloricIntake";

  static Future<void> saveCaloricIntake(int caloricIntake) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, caloricIntake);
  }

  static Future<int> getCaloricIntake() async {
    final box = await Hive.openBox(boxName);
    return box.get(key) ?? 0;
  }
}
