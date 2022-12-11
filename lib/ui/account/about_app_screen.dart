import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/utils/error.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:naql/providers/about_app_provider.dart';
import 'dart:math' as math;
import 'package:flutter_html/flutter_html.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
double _height = 0 , _width = 0;




Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Container(
      height: _height,
      width: _width,
      child: Column(
     
        children: <Widget>[
          SizedBox(
            height: 120,
          ),

          Container(
            alignment: Alignment.center,

            child:  Image.asset('assets/images/logo.png'),
          ),
               Expanded(
                 child: FutureBuilder<String>(
                    future: Provider.of<AboutAppProvider>(context,
                            listen: false)
                        .getAboutApp() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: _width * 0.04),
                                child: Html(data: snapshot.data));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
               )
 
          
            
   

            
        ],
      ),
    ),
  );
}

@override
  Widget build(BuildContext context) {
    _height =
        _height =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
                  child:
                  Column(
                    children: <Widget>[
                      Row(
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
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Text( AppLocalizations.of(context).translate('about_app'),
                              style: Theme.of(context).textTheme.headline1),
                          Spacer(
                            flex: 3,
                          ),
                        ],
                      ),


                    ],
                  )

              ) ,




            ],
          )),
    );
  }
}