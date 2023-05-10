import 'package:shared_preferences/shared_preferences.dart';
import 'package:skadi/skadi.dart';

bool _loggedIn = false;

class AuthController {
  bool loggedIn = false;

  AuthController() {
    loggedIn = _loggedIn;
    debugLog("Auth?", loggedIn);
  }

  Future login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", "jwt");
    loggedIn = true;
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    loggedIn = false;
  }

  static Future init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    _loggedIn = token != null;
  }
}
