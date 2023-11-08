import 'package:shared_preferences/shared_preferences.dart';

class SPWorker {
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> saveLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);
  }
}
