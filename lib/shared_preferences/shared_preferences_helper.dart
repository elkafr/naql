import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return json.decode(prefs.getString(key));
    } else {
      return null;
    }
  }

  static save(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

// save value "first_time" to show intro of the app or not 
 static Future<bool> setFirstTime(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("first_time", value);
  }

  static Future<bool> checkIsFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("first_time") ?? true;
  }
  
///-----------------
  ///Save boolean values
  ///------------------

  static Future<bool> getBoolean(String key) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key) ? prefs.getBool(key ?? false) : false;
  }

  static Future<bool> saveBoolean(
      String key, bool value, SharedPreferences prefs) {
    return prefs.setBool(key, value);
  }
   
   
  static Future<bool> setUserLang(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("lang", language);
  }

  static Future<String> getUserLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("lang") ?? 'ar';
  }

}
