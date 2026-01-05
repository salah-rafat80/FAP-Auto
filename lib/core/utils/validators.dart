// Core utility functions

/// Validate mobile number format
bool isValidMobileNumber(String mobile) {
  return mobile.startsWith('05') && mobile.length == 10;
}

/// Format mobile number for display
String formatMobileNumber(String mobile) {
  if (mobile.length != 10) return mobile;
  return '${mobile.substring(0, 3)} ${mobile.substring(3, 6)} ${mobile.substring(6)}';
}

