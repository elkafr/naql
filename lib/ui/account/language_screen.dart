import 'package:naql/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/locale/locale_helper.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/shared_preferences/shared_preferences_helper.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;



class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  double _height, _width;
AuthProvider _authProvider;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
         SizedBox(
            height: 70,
          ),
        GestureDetector(
          onTap: () {
           if(_authProvider.currentLang != 'ar'){
               SharedPreferencesHelper.setUserLang('ar');
            helper.onLocaleChanged(new Locale('ar'));
            _authProvider.setCurrentLanguage('ar');
           }
        
      
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: Image.asset('assets/images/arabic.png'),
              ),
              Text(
                  AppLocalizations.of(context).translate('arabic'),
               
                style: TextStyle(color: Colors.black, fontSize: 15),
              )
            ],
          ),
        ),
        Divider(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            if(_authProvider.currentLang != 'en'){
   SharedPreferencesHelper.setUserLang('en');
            helper.onLocaleChanged( Locale('en'));
            _authProvider.setCurrentLanguage('en');
         
            }
            
         
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: Image.asset('assets/images/english.png'),
              ),
              Text(
                AppLocalizations.of(context).translate('english'),
                style: TextStyle(color: Colors.black
                , fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
     _authProvider   = Provider.of<AuthProvider>(context);
  

    _height = MediaQuery.of(context).size.height -
      
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          _buildBodyItem(),
           Container(
              height: 60,
              decoration: BoxDecoration(
                color: omarColor,


              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Consumer<AuthProvider>(
                      builder: (context,authProvider,child){
                        return authProvider.currentLang == 'ar' ? Image.asset(
                      'assets/images/back.png',
                      color: Colors.white,
                    ): Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child:  Image.asset(
                      'assets/images/back.png',
                      color: Colors.white,
                    ));
                      },
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text( AppLocalizations.of(context).translate('language'),
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 3,
                  ),
                ],
              )),
        ],
      )),
    );
  }
}
