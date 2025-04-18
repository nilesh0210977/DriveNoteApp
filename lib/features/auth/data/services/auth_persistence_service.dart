import 'package:shared_preferences/shared_preferences.dart';

class AuthPersistenceService {
  static const String _isSignedInKey = 'is_signed_in';

  Future<bool> isUserSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSignedInKey) ?? false;
  }

  Future<void> setUserSignedIn(bool isSignedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSignedInKey, isSignedIn);
  }
}
