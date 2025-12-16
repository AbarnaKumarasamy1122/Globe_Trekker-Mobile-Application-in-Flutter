import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isInitialized = false;
  String? _selectedCountry;
  bool _isDarkMode = false;
  String _currentView = 'home';

  bool get isInitialized => _isInitialized;
  String? get selectedCountry => _selectedCountry;
  bool get isDarkMode => _isDarkMode;
  String get currentView => _currentView;

  void setInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  void setSelectedCountry(String? country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setCurrentView(String view) {
    _currentView = view;
    notifyListeners();
  }

  void reset() {
    _isInitialized = false;
    _selectedCountry = null;
    _isDarkMode = false;
    _currentView = 'home';
    notifyListeners();
  }
}
