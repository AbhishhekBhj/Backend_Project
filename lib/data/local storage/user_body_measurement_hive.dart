import 'package:hive/hive.dart';

class UserBodyMeasurementLocalStorage {
  //opening hive box

  static final Box<dynamic> userBodyMeasurementStore =
      Hive.box('userBodyMeasurementStore');

  static Future<void> saveBodyWeight(double bodyWeight) async {
    await userBodyMeasurementStore.put('bodyWeight', bodyWeight);
  }
}
