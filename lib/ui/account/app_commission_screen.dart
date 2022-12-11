import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/commission_app.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/commission_app_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:naql/providers/home_provider.dart';
import 'package:naql/utils/error.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/ui/account/pay_commission_screen.dart';
import 'package:flutter_html/flutter_html.dart';

class AppCommissionScreen extends StatefulWidget {
  @override
  _AppCommissionScreenState createState() => _AppCommissionScreenState();
}

class _AppCommissionScreenState extends State<AppCommissionScreen> {
double _height = 0 , _width = 0;
HomeProvider _homeProvider;

String _adValue;
bool _initialRun = true;
CommisssionAppProvider _commisssionAppProvider;
Future<CommissionApp> _commissionApp;

  @override
  void didChangeDependencies() {

    
    super.didChangeDependencies();
    if (_initialRun) {
     
      _commisssionAppProvider = Provider.of<CommisssionAppProvider>(context);
      _commissionApp = _commisssionAppProvider.getCommissionApp();
      _initialRun = false;
    }
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Container(
            width:  _width *0.55,
            child: Text(
              value,
               overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,fontSize: 12, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Container(
      height: _height,
      width: _width,
      child: FutureBuilder<CommissionApp>(
         future: _commissionApp,
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
                   errorMessage:AppLocalizations.of(context).translate('error'),
                 );
               } else {


            return    Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  SizedBox(
            height: 100,
          ),


              Padding(padding: EdgeInsets.all(25),
                child:         Container(
           margin:
           EdgeInsets.symmetric(horizontal: _width * 0.04),
           child: Html(data: snapshot.data.about))
              ),

           Consumer<AuthProvider>(
             builder: (context,authProvider,child){
               return  Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              alignment:  authProvider.currentLang == 'ar' ? Alignment.topRight : Alignment.topLeft,
              child: Text(_homeProvider.currentLang=="ar"?"حساب العمولة":"Commition Calculate",style: TextStyle(
                color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700
              ),),
            );
             }
           ),
              CustomTextFormField(

                 inputData: TextInputType.number,
                   hintTxt: _homeProvider.currentLang=="ar"?"سعر الاعلان":"Ads price",
                   suffix:Text( AppLocalizations.of(context).translate('sr')), 
                    onChangedFunc: (text){
                      _adValue =text;
                      var commissionValue = double.parse(_adValue) * (double.parse(snapshot.data.commition) /100);
                    _commisssionAppProvider.setCommissionValue(commissionValue.toString());
                    },
                   
                ),


             SizedBox(
               height: 15,
             ),

            Container(

           decoration: BoxDecoration(

           border: Border.all(
           color: hintColor.withOpacity(0.9),
             style: BorderStyle.solid

           ),
             color: accentColor,

           ),
              padding: EdgeInsets.all(10),
              width: _width*.85,

              child: Column(

                children: <Widget>[
                  Consumer<AuthProvider>(
                      builder: (context,authProvider,child){
                        return   Container(
                          margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                          alignment:  authProvider.currentLang == 'ar' ? Alignment.topRight : Alignment.topLeft,
                          child: Text(AppLocalizations.of(context).translate('value_of_commission_due'),style: TextStyle(
                              color: mainAppColor,fontSize: 13,fontWeight: FontWeight.w700
                          ),),
                        );}),
                  Container(
                      margin: EdgeInsets.only(
                          top: 10
                      ),
                      child: Consumer<CommisssionAppProvider>
                        (
                          builder: (context,commisssionAppProvider,child){
                            return Text('${commisssionAppProvider.commissionValue} ${AppLocalizations.of(context).translate('sr')}');
                          }
                      )
                  ),





                ],
              ),
            ),

                Container(
                    alignment: Alignment.center,
                    child: Text('${AppLocalizations.of(context).translate('app_commission')} ${snapshot.data.commition} %' ,style: TextStyle(
                        color: hintColor
                    ),)),

                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  btnLbl: _homeProvider.currentLang=="ar"?"دفع العمولة":"Pay commission",
                  btnColor: mainAppColor,
                  onPressedFunction: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PayCommissionScreen()));
                  },
                )

              ],
            );
               }
           }
           return Center(
             child: SpinKitFadingCircle(color: mainAppColor),
           );
         }),
    ),
  );
}

@override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _homeProvider = Provider.of<HomeProvider>(context);
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
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text( AppLocalizations.of(context).translate('app_commission'),
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