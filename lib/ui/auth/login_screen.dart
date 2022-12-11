import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/user.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/shared_preferences/shared_preferences_helper.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin{
double _height = 0 , _width = 0;
 final _formKey = GlobalKey<FormState>();
 AuthProvider _authProvider;
 ApiProvider _apiProvider = ApiProvider();
 bool _isLoading = false;
 String _userPhone ='' ,_userPassword ='';
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  
Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 160,
          ),

          Container(
            alignment: Alignment.center,

            child:  Image.asset('assets/images/logo.png'),
          ),

          Container(
            margin: EdgeInsets.symmetric(
              vertical: _height *0.02
            ),
            child: CustomTextFormField(
              onChangedFunc: (text){
                _userPhone = text;
              },
              
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/call.png',
                  hintTxt:  AppLocalizations.of(context).translate('phone_no'),
                     validationFunc: validateUserPhone,
                ),
          ),
          
           
          
            CustomTextFormField(
              isPassword: true,
                prefixIconIsImage: true,
                onChangedFunc: (text){
                  _userPassword =text;
                },
                prefixIconImagePath: 'assets/images/key.png',
                hintTxt: AppLocalizations.of(context).translate('password'),
                   validationFunc: validatePassword,
            ),
          
            Container(
              margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
               child: GestureDetector(
                 onTap: ()=> Navigator.pushNamed(context,  '/phone_password_reccovery_screen' ),
                 child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color:Colors.black , fontSize: 14, fontFamily: 'Cairo'),
                              children: <TextSpan>[
                                TextSpan(text:  AppLocalizations.of(context).translate('forget_password')),
                                TextSpan(
                                  text:  AppLocalizations.of(context).translate('click_her'),
                                  style: TextStyle(
                                      color: Color(0xffA8C21C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Cairo'),
                                ),
                              ],
                            ),
                          ),
               ),
            )
       
         , _buildLoginBtn()
      ,
         Container(
           margin: EdgeInsets.symmetric(vertical: _height *0.02),
           child: 
        Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(
                              right: _width * 0.08, left: _width * 0.02),
                          child: Divider(
                            color: Color(0xffC5C5C5),
                            height: 2,
                            thickness: 1,
                          ),
                        )),
                        Center(
                          child: Text(
                         AppLocalizations.of(context).translate('or'),
                            style: TextStyle(
                                color: Color(0xffC5C5C5),
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(
                              left: _width * 0.08, right: _width * 0.02),
                          child: Divider(
                            color: Color(0xffC5C5C5),
                            height: 2,
                            thickness: 1,
                          ),
                        ))
                      ],
                    ),
         ),
       CustomButton(
           btnLbl:  AppLocalizations.of(context).translate('register'),
           btnColor: Colors.white,
           btnStyle: TextStyle(
             color: mainAppColor
           ),
           onPressedFunction: (){
             Navigator.pushNamed(context, '/register_screen');
           },
         ),
        ],
      ),
    ),
  );
}

 Widget _buildLoginBtn() {
    return _isLoading
        ? Center(
            child:SpinKitFadingCircle(color: mainAppColor),
          )
        : CustomButton(
              btnLbl:  AppLocalizations.of(context).translate('login'),
              onPressedFunction: () async {
                
                if (_formKey.currentState.validate()) {
                     _firebaseMessaging.getToken().then((token) async {
                  print('token: $token');
          
                  setState(() {
                    _isLoading = true;
                  });
                 final results = await _apiProvider
                      .post(Urls.LOGIN_URL +"?api_lang=${_authProvider.currentLang}", body: {
                    "user_phone":  _userPhone,
                    "user_pass": _userPassword,
                    "token":token
                   
                  });
               
            setState(() => _isLoading = false);
                  if (results['response'] == "1") {
                     _login(results);
                      
                  } else {
                    Commons.showError(context, results["message"]);
                
                  }
                     });
                   
                }
              },
            );
  }

   _login(Map<String,dynamic> results) {
    _authProvider.setCurrentUser(User.fromJson(results["user_details"]));
    SharedPreferencesHelper.save("user", _authProvider.currentUser);
    Commons.showToast( context,message:results["message"] ,color:  mainAppColor);
    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/navigation', (Route<dynamic> route) => false);
  }


  @override
  Widget build(BuildContext context) {
         _height =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
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
                     Text( AppLocalizations.of(context).translate('login'),
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
      )
      ),
    );
  }
}