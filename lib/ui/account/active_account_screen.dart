import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ActiveAccountScreen extends StatefulWidget {
  @override
  _ActiveAccountScreenState createState() => _ActiveAccountScreenState();
}

class _ActiveAccountScreenState extends State<ActiveAccountScreen>
    with ValidationMixin {
  double _height = 0, _width = 0;
  bool _isLoading = false;
  String _activationCode = '';
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
  HomeProvider _homeProvider;
  final _formKey = GlobalKey<FormState>();

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: _height * 0.05),
              child: Image.asset(
                ' assets/images/full_reset.png',
                height: _height * 0.2,
              ),
            ),
            Text(
             _homeProvider.currentLang=="ar"?"كود تفعيل الحساب":"Active Account COde",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(bottom: _height * 0.02),
              child: Text(
                
              _homeProvider.currentLang=="ar"?"ادخل الكود المرسل على هاتفك لتفعيل الحساب":"Enter the code sent on your phone to activate the account",
                style: TextStyle(color: Color(0xffC5C5C5), fontSize: 14),
              ),
            ),
            CustomTextFormField(
              prefixIconIsImage: true,
              prefixIconImagePath: 'assets/images/edit.png',
              hintTxt:  AppLocalizations.of(context).translate('code_here'),
              onChangedFunc: (text) {
                _activationCode = text;
              },
              validationFunc: validateActivationCode,
            ),
            SizedBox(
              height: _height * 0.01,
            ),
            _buildRecoveryBtn(),

          ],
        ),
      ),
    );
  }

  Widget _buildRecoveryBtn() {
    return  CustomButton(
            btnLbl: _homeProvider.currentLang=="ar"?"تفعيل":"Active",
            onPressedFunction: () async {
              if (_formKey.currentState.validate()) {
                setState(() {
                  _isLoading = true;
                });
                final results =
                    await _apiProvider.post("https://naql-app.com/api/activate?api_lang=${_authProvider.currentLang}", body: {
                  "activation_code": _activationCode,
                });

                setState(() => _isLoading = false);
                if (results['response'] == "1") {
                  _authProvider.setActivationCode(_activationCode);
                  Commons.showToast(context, message: results["message"],color: mainAppColor);
                  Navigator.pushNamed(context, '/login_screen');
                } else {
                  Commons.showError(context, results["message"]);
                }
              }
            },
          );
  }



  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
    return PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          _buildBodyItem(),
          Container(
              height: 60,
              decoration: BoxDecoration(
                color: mainAppColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
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
                    flex: 1,
                  ),
                  Text(_homeProvider.currentLang=="ar"?"تفعيل الحساب":"Active account",
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 2,
                  ),
                ],
              )),
        _isLoading
        ? Center(
            child: SpinKitFadingCircle(color: mainAppColor),
          )
        :Container()
        ],
      )),
    );
  }
}
