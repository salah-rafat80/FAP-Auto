// filepath: d:\StudioProjects\FAP\fap\lib\core\utils\auth_session.dart
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing authentication session
class AuthSession {
  static const String _tokenKey = 'auth_token';
  static const String _phoneKey = 'user_phone';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userNameKey = 'user_name';

  final SharedPreferences _prefs;

  AuthSession(this._prefs);

  /// Check if user is logged in
  bool get isLoggedIn => _prefs.getBool(_isLoggedInKey) ?? false;

  /// Get stored auth token
  String? get token => _prefs.getString(_tokenKey);

  /// Get stored phone number
  String? get phone => _prefs.getString(_phoneKey);

  /// Get stored user name
  String? get userName => _prefs.getString(_userNameKey);

  /// Save login data
  Future<void> saveLoginData({
    required String token,
    required String phone,
    String? userName,
  }) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_phoneKey, phone);
    await _prefs.setBool(_isLoggedInKey, true);
    if (userName != null) {
      await _prefs.setString(_userNameKey, userName);
    }
  }

  /// Clear all session data (logout)
  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_phoneKey);
    await _prefs.remove(_userNameKey);
    await _prefs.setBool(_isLoggedInKey, false);
  }
}
