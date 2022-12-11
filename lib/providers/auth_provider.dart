
import 'package:flutter/material.dart';
import 'package:naql/models/user.dart';


class AuthProvider extends ChangeNotifier {

 // current language from shared prefernces 'ar' or 'en'
  String _currentLang;

  void setCurrentLanguage(String currentLang) {
    _currentLang = currentLang;
    notifyListeners();
  }

  String get currentLang => _currentLang;

  User _currentUser;
  
  void setCurrentUser(User currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  User get currentUser => _currentUser;

   String _activationCode;

  void setActivationCode(String activationCode) {
    _activationCode = activationCode;
    notifyListeners();
  }

  String get activationCode => _activationCode;

     String _userPhone;

  void setUserPhone(String userPhone) {
    _userPhone = userPhone;
    notifyListeners();
  }

  String get userPhone => _userPhone;




}
