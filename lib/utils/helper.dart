import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  static SharedPreferences? prefs;

  static Future<void> initializeSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }
}
