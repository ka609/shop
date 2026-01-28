import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isAdmin = false;

  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  bool get isAdmin => _isAdmin;
  String? get userEmail => _userEmail;

  // ADMIN PAR DÉFAUT (MOCK)
  final String _adminEmail = 'admin@shop.com';
  final String _adminPassword = 'admin123';

  // LOGIN
  bool login(String email, String password) {
    // Admin
    if (email == _adminEmail && password == _adminPassword) {
      _isAuthenticated = true;
      _isAdmin = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }

    // User mock
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _isAdmin = false;
      _userEmail = email;
      notifyListeners();
      return true;
    }

    return false;
  }

  // INSCRIPTION USER (MOCK)
  void registerUser(String email) {
    _isAuthenticated = true;
    _isAdmin = false;
    _userEmail = email;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _isAdmin = false;
    _userEmail = null;
    notifyListeners();
  }
}
