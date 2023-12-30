import 'package:hive/hive.dart';

class UserWaterIntakeLocalStorage {

//opening hive box

  static final Box<dynamic> userWaterIntakeStore = Hive.box('userWaterIntakeStore');

 static Future<void> saveWaterVolume(double waterIntake) async{
    userWaterIntakeStore.put('waterIntake', waterIntake);
 }

  static double getWaterVolume(){
    return userWaterIntakeStore.get('waterIntake') as double;
  }


}
