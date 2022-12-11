import 'package:flutter/material.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/category.dart';
import 'package:naql/models/city.dart';
import 'package:naql/models/country.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/utils/urls.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/ui/ad_details/ad_details_screen.dart';


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



ApiProvider _apiProvider = ApiProvider();

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({Key key}) : super(key: key);
  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> with ValidationMixin
  {
  String _keySearch = '';
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  Future<List<Country>> _countryList;
  City _selectedCity;
  Country _selectedCountry;
  CategoryModel _selectedCategory;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  AuthProvider _authProvider ;

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _homeProvider = Provider.of<HomeProvider>(context);
      _initialRun = false;

    }
  }

  Widget build(BuildContext context) {

    _authProvider = Provider.of<AuthProvider>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
            child: Form(
            key: _formKey,
                child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: ListView(children: <Widget>[

                Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: mainAppColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate('addcomment'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                Padding(padding: EdgeInsets.all(35)),
                Image.asset("assets/images/logo.png",height: 100,),
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.04),
                  child: InkWell(
                    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                    child: CustomTextFormField(

                        hintTxt: AppLocalizations.of(context).translate('writecomment'),

                        onChangedFunc: (String text) {
                          _keySearch = text;
                        }),
                  ),
                ),



                Padding(padding: EdgeInsets.all(20)),


                CustomButton(
                  btnLbl:  AppLocalizations.of(context).translate('addcomment'),
                  btnColor: accentColor,
                  onPressedFunction: () async{




                    final results = await _apiProvider
                        .post(Urls.ADD_COMMENT , body: {
                      "ads_id":  _homeProvider.currentAds,
                      "comment_details":_keySearch,
                      "user_id": _authProvider.currentUser.userId,


                    });


                    if (results['response'] == "1") {
                      Commons.showToast(context, message: results["message"] );
                      Navigator.pop(context);

                    } else {
                      Commons.showError(context, results["message"]);

                    }




                  },
                ),
              ]),
            )),
          ));
    });
  }
}
