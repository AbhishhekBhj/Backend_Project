import 'package:hive/hive.dart';

class UserWorkoutLocalStorage {
  //opening hive box

  static final Box<dynamic> userWorkoutStore = Hive.box('userWorkoutStore');
  static Future<void> saveSetsPerformed(List<String> setsPerformed) async {
    await userWorkoutStore.put('setsPerformed', setsPerformed);
  }

  static Future<void> saveRepsPerformed(List<String> repsPerformed) async {
    await userWorkoutStore.put('repsPerformed', repsPerformed);
  }

  static Future<void> saveWeightsLifted(List<String> weightsLifted) async {
    await userWorkoutStore.put('weightsLifted', weightsLifted);
  }

  static Future<void> saveExercisesDone(List<String> exercisesDone) async {
    await userWorkoutStore.put('exercisesDone', exercisesDone);
  }

  //now getting data from hive box

  static List<String> getSetsPerformed() {
    return userWorkoutStore.get('setsPerformed') as List<String>;
  }

  static List<String> getRepsPerformed() {
    return userWorkoutStore.get('repsPerformed') as List<String>;
  }

  static List<String> getWeightsLifted() {
    return userWorkoutStore.get('weightsLifted') as List<String>;
  }

  static List<String> getExercisesDone() {
    return userWorkoutStore.get('exercisesDone') as List<String>;
  }

}
