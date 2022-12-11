import 'package:flutter/material.dart';
import 'package:naql/models/ad.dart';
import 'package:naql/models/user.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/utils/urls.dart';

  class MyAdsProvider extends ChangeNotifier {
    ApiProvider _apiProvider = ApiProvider();
  User _currentUser;
  String _currentLang;

  void update(AuthProvider authProvider) {
    _currentUser = authProvider.currentUser;
    _currentLang =  authProvider.currentLang;
  }
     Future<List<Ad>> getMyAdsList() async {

    final response = await _apiProvider.get(
        Urls.MY_ADS_URL + 'user_id=${_currentUser.userId}&page=1&api_lang=$_currentLang' );
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['requests'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }

    return adsList;
  }


  }