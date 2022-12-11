import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/country.dart';
import 'package:naql/models/user.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/shared_preferences/shared_preferences_helper.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class EditPersonalInfoScreen extends StatefulWidget {
  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> with ValidationMixin {
 double _height = 0 , _width = 0;
 String _userName = '',_userPhone = '',_userEmail ='';
 AuthProvider _authProvider;
 bool _initialRun = true;
 bool _isLoading = false;
 Country _selectedCountry;
 bool _initSelectedCountry = true;
  Future<List<Country>> _countryList;
  HomeProvider _homeProvider;
    final _formKey = GlobalKey<FormState>();
  ApiProvider _apiProvider = ApiProvider();

 
 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
      
      _countryList = _homeProvider.getCountryList();
      _userName = _authProvider.currentUser.userName;
      _userPhone = _authProvider.currentUser.userPhone;
      _userEmail = _authProvider.currentUser.userEmail;
      _initialRun = false;
    }
  }
Widget _buildBodyItem(){
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
               initialValue: _userName,
                prefixIconIsImage: true,
                prefixIconImagePath: 'assets/images/user.png',
                hintTxt:AppLocalizations.of(context).translate('user_name'),
                validationFunc:validateUserName
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: _height *0.02),
                child: CustomTextFormField(
                  initialValue: _userPhone,
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/call.png',
                  hintTxt:  AppLocalizations.of(context).translate('phone_no'),
                  validationFunc: validateUserPhone
                ),
              ),
                CustomTextFormField(
                  initialValue: _userEmail,
                  prefixIconIsImage: true,
                  prefixIconImagePath: 'assets/images/mail.png',
                  hintTxt: AppLocalizations.of(context).translate('email'),
                  validationFunc:  validateUserEmail
              ),
               

Spacer(),
            CustomButton(
              btnLbl: AppLocalizations.of(context).translate('save'),
              onPressedFunction: () async {
if (_formKey.currentState.validate()){
setState(() => _isLoading = true);
                    FormData formData = new FormData.fromMap({
                      "user_id": _authProvider.currentUser.userId,
                      "user_name":  _userName,        
                      "user_phone" : _userPhone,
                      "user_email":  _userEmail,
                    
                    });
                    final results = await _apiProvider
                        .postWithDio(Urls.PROFILE_URL + "?api_lang=${_authProvider.currentLang}", body: formData);
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
 
              },
              ),
              
SizedBox(
  height: _height *0.02,
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
                  Text( AppLocalizations.of(context).translate('edit_info'),
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