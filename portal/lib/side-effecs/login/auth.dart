import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final SharedPreferences _prefs;

  AuthRepository(this._prefs);

  // O Side-effect puro: vai ao disco e volta
  Future<String?> getToken() async {
    return _prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  Future<void> removeToken() async {
    await _prefs.remove('auth_token');
  }
}
