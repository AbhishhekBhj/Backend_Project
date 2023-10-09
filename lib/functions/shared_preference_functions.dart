import "package:shared_preferences/shared_preferences.dart";

// this file will contain all the function to set and get values wherever shared preference is required

class SharedPreferenceFunctions {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceFunctions(this._sharedPreferences);

  Future<void> setStringSharedPreference(String key, String value) async {
    /*
    This function will be used to Set String values for shared Preference
    
    */
    await _sharedPreferences.setString(key, value);
  }

  String? getStringSharedPreference(String key) {
    /*
    This function will be used to get String values stored in the key of the shared preference
    
    */

    return _sharedPreferences.getString(key);
  }

  Future<void> setDouble(String key, double value) async {
    /*
    This function will be used to Set Double values for shared Preference
    
    */
    await _sharedPreferences.setDouble(key, value);
  }

  double? getDouble(String key) {
    /*
    This function will be used to get Double values from shared preference
    
    */
    return _sharedPreferences.getDouble(key);
  }

  Future<void> clearSharedPreferenceValue(String key) async {
    /*
    This function will be used to clear the value stored in the shared preference
    
    */
    _sharedPreferences.remove(key);
  }

  Future<void> setBool(String key, bool value) async {
    /*
    This function will be used to set  value  in the shared preference
    
    */
    await _sharedPreferences.setBool(key, value);
  }

  // Getter function to retrieve a boolean
  bool? getBool(String key) {
/*
    This function will be used to get  value  from shared preference
    
    */

    return _sharedPreferences.getBool(key);
  }
}
