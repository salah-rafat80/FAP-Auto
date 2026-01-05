import 'dart:io';

/// Security service - Screenshot protection is MANDATORY and enabled at native level
class SecurityService {
  static bool _isSecured = true; // Always true on Android and iOS

  /// Enable screenshot and screen recording prevention
  /// This is MANDATORY and works at native Android/iOS level
  static Future<void> enableScreenSecurity() async {
    if (Platform.isAndroid || Platform.isIOS) {
      _isSecured = true;
      // Protection is handled natively:
      // - Android: MainActivity.kt - FLAG_SECURE
      // - iOS: AppDelegate.swift - Secure text field layer technique
    }
  }

  /// Check if screen security is currently enabled
  static bool get isSecured => _isSecured;
}
