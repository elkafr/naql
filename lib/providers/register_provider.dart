import 'package:flutter/material.dart';
import 'package:naql/models/country.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/utils/urls.dart';

class RegisterProvider extends ChangeNotifier{

  
  String _currentLang;

  void update(AuthProvider authProvider) {

    _currentLang = authProvider.currentLang;
  }

  ApiProvider _apiProvider = ApiProvider();
    List<Country> _countryList =  List<Country>();

  List<Country> get countryList => _countryList;

    Future<List<Country>> getCountryList() async {
     final response = await _apiProvider
        .get(Urls.GET_COUNTRY_URL + "?api_lang=$_currentLang");
     if (response['response'] == "1") {
      Iterable iterable = response['country'];
       _countryList =
          iterable.map((model) => Country.fromJson(model)).toList();
      return _countryList;
    }
    return null;
  }

  Country _userCountry;

  void setUserCountry(Country userCountry) {
    _userCountry = userCountry;
    notifyListeners();
  }

  Country get userCountry => _userCountry;


   bool _acceptTerms = false;

  void setAcceptTerms(bool acceptTerms) {
    _acceptTerms = acceptTerms;
    notifyListeners();
  }

  bool get acceptTerms => _acceptTerms;

}