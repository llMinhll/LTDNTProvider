
import 'package:flutter/foundation.dart';
class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _username;
  bool _isAuthenticated = false;
  String? get userId => _userId;
  String? get username => _username;
  bool get isAuthenticated => _isAuthenticated;
  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (password == '123456') {
      _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _username = username;
      _isAuthenticated = true;
      notifyListeners();
      debugPrint('✅ Login thành công: $_username (ID: $_userId)');
    } else {
      throw Exception('Sai mật khẩu!');
    }
  }
  void logout() {
    _userId = null;
    _username = null;
    _isAuthenticated = false;
    notifyListeners();
    debugPrint('👋 Logout thành công');
  }

  bool checkAuth() {
    return _isAuthenticated && _userId != null;
  }
}
