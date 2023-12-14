import 'package:shared_preferences/shared_preferences.dart';
import 'package:skadi/skadi.dart';

bool _loggedIn = false;

class AuthController {
  bool loggedIn = false;

  static late SharedPreferences _sharedPreferences;

  AuthController() {
    print("Auth controller constructor");
    loggedIn = _loggedIn;
  }

  Future login(String email, String password) async {
    if (email != "admin@email.com" && password != "admin") {
      throw "Incorrect email or password";
    }
    _sharedPreferences.setString("token", "jwt");
    loggedIn = true;
  }

  Future logout() async {
    _sharedPreferences.clear();
    loggedIn = false;
  }

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString("token");
    _loggedIn = token != null;
    debugLog("Auth?", _loggedIn);
  }
}
