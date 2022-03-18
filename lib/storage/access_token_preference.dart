import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenStorage {
  Future<bool> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return true;
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token;
  }
}
