import 'package:dio/dio.dart';
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

class EditPasswordScreen extends StatefulWidget {
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> with ValidationMixin {
  double _height = 0, _width = 0;
     final _formKey = GlobalKey<FormState>();
      AuthProvider _authProvider;
      ApiProvider _apiProvider=  ApiProvider();
      String _oldPassword = '',_newPassword ='';

 bool _isLoading = false;

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Container(
        height: _height,
        width: _width,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              CustomTextFormField(
                isPassword: true,
                prefixIconIsImage: true,
                prefixIconImagePath: 'assets/images/key.png',
                hintTxt: AppLocalizations.of(context).translate('old_password'),
                onChangedFunc: (text){
                  _oldPassword =text;
                },
                validationFunc: validatePassword
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: _height * 0.02),
                child: CustomTextFormField(
                  isPassword: true,
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/key.png',
                  hintTxt: AppLocalizations.of(context).translate('new_password'),
                     onChangedFunc: (text){
                  _newPassword =text;
                },
                  validationFunc: validatePassword
                ),
              ),
              CustomTextFormField(
                isPassword: true,
                prefixIconIsImage: true,
                prefixIconImagePath: 'assets/images/key.png',
                hintTxt:  AppLocalizations.of(context).translate('confirm_new_password'),
                validationFunc: validateConfirmPassword
              ),
              Spacer(),
              CustomButton(
                btnLbl: AppLocalizations.of(context).translate('save'),
                onPressedFunction: () async{
                             
if (_formKey.currentState.validate() 
){
setState(() => _isLoading = true);
                    FormData formData = new FormData.fromMap({
                      "user_id": _authProvider.currentUser.userId,
                      "user_name":  _authProvider.currentUser.userName,        
                      "user_phone" : _authProvider.currentUser.userPhone,
                      "user_email":  _authProvider.currentUser.userEmail,
                      "old_pass":_oldPassword,
                      "user_pass":_newPassword,
                      "user_pass_confirm":_newPassword,
                     "user_country":_authProvider.currentUser.userCountry,
                    
                    });
                    final results = await _apiProvider
                        .postWithDio(Urls.PROFILE_URL+ "?api_lang=${_authProvider.currentLang}", body: formData);
                    setState(() => _isLoading = false);

                    if (results['response'] == "1") {
                      _authProvider
                          .setCurrentUser(User.fromJson(results["user"]));
                      SharedPreferencesHelper.save(
                          "user", _authProvider.currentUser);
                      Commons.showToast(context,message: results["message"] );
                      Navigator.pop(context);
                    } else {
                      Commons.showError(context, results["message"]);
                    }
}
                }
              
              ),
              SizedBox(
                height: _height * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
                  Text( AppLocalizations.of(context).translate('edit_password'),
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 3,
                  ),
                ],
              )),
                      _isLoading
        ? Center(
            child:SpinKitFadingCircle(color: mainAppColor),
          )
        :Container()
        ],
      )),
    );
  }
}
