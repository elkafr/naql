import 'package:flutter/material.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/utils/urls.dart';

import 'auth_provider.dart';

class TermsProvider extends ChangeNotifier{
   ApiProvider _apiProvider = ApiProvider();
    
 String _currentLang;


  void update(AuthProvider authProvider) {
 
    _currentLang = authProvider.currentLang;
  }
  Future<String> getTerms() async {
    final response =
        await _apiProvider.get(Urls.TERMS_URL +"?api_lang=$_currentLang");
    String terms = '';
    if (response['response'] == '1') {
      terms = response['messages'];
    }
    return terms;
  }




   Future<String> getFace() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_face'];
     }
     return terms;
   }

   Future<String> getTwitt() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_twitt'];
     }
     return terms;
   }

   Future<String> getSnap() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_snap'];
     }
     return terms;
   }


   Future<String> getLinkid() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_linkid'];
     }
     return terms;
   }

   Future<String> getInst() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_inst'];
     }
     return terms;
   }


   Future<String> getAppstore() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_appstore'];
     }
     return terms;
   }



   Future<String> getGoogleplay() async {
     final response =
     await _apiProvider.get(Urls.Social +"?api_lang=$_currentLang");
     String terms = '';
     if (response['response'] == '1') {
       terms = response['setting_googleplay'];
     }
     return terms;
   }



}

