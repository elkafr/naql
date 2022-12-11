import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/providers/commission_app_provider.dart';
import 'package:naql/models/commission_app.dart';
import 'package:naql/utils/error.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;




import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/dialogs/confirmation_dialog.dart';
import 'package:naql/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/category.dart';
import 'package:naql/models/city.dart';
import 'package:naql/models/country.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/providers/navigation_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:naql/models/marka.dart';
import 'package:naql/models/model.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;

import 'package:naql/providers/commission_app_provider.dart';
import 'package:naql/models/commission_app.dart';

class PayCommission1Screen extends StatefulWidget {
  @override
  _PayCommission1ScreenState createState() => _PayCommission1ScreenState();
}

class _PayCommission1ScreenState extends State<PayCommission1Screen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  ApiProvider _apiProvider = ApiProvider();
  bool _isLoading = false;
  bool _initialRun = true;
  AuthProvider _authProvider;
  String _commitionV1 ='' ,_commitionV2 ='' , _commitionV3 ='', _commitionV4 ='', _commitionV5 ='', _commitionV6 ='', _commitionV7 ='';
  HomeProvider _homeProvider;
  CommisssionAppProvider _commisssionAppProvider;
  Future<CommissionApp> _commissionApp;
  File _imageFile4;
  final _picker = ImagePicker();
  dynamic _pickImageError;


  void _onImageButtonPressed4(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile4 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }




  void _settingModalBottomSheet4(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('Gallery'),
                    onTap: (){
                      _onImageButtonPressed4(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed4(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
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

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),


            Container(
              alignment: Alignment.center,
              height: 70,
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
                          return  Container(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(_homeProvider.currentLang=="ar"?"قيمة تمييز الاعلان":"Ad distinction value"),
                                Text(snapshot.data.commition1,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text( AppLocalizations.of(context).translate('sr'))
                              ],
                            ),
                          );
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  }),
            ),
            

            Container(
              height: 200,
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
                          return  Container(
                            child: ListView.builder(
                                itemCount: snapshot.data.banks.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          const Radius.circular(15.00),
                                        ),
                                        border: Border.all(color: hintColor)),
                                    height: 160,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                                color: accentColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: (Radius.circular(15.0)),
                                                    topRight: (Radius.circular(15.0)))),
                                            height: 45,
                                            width: _width,
                                            child: Center(
                                              child: Row(
                                                children: <Widget>[
                                                  Image.network(snapshot.data.banks[index].bankPhoto),
                                                  Padding(padding: EdgeInsets.all(7)),
                                                  Text(
                                                    snapshot.data.banks[index].bankTitle,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            )),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          child: _buildRow(
                                              '${AppLocalizations.of(context).translate('account_owner')}   :   ',
                                              snapshot.data.banks[index].bankName),
                                        ),
                                        _buildRow(
                                            '${AppLocalizations.of(context).translate('account_number')} :   ',
                                            snapshot.data.banks[index].bankAcount),

                                        _buildRow(
                                            'رقم الايبان :   ',
                                            snapshot.data.banks[index].bankIban),


                                        /* Container(
                              margin: EdgeInsets.only(top: 10),
                              child: _buildRow(
                                  '${AppLocalizations.of(context).translate('iban_number')}  :   ',
                                  snapshot.data.banks[index].bankIban),
                            )*/


                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5),child: Text(_homeProvider.currentLang=="ar"?"أسم المستخدم":"user name"),),
                CustomTextFormField(

                    prefixIconIsImage: false,
                    onChangedFunc: (text){
                      _commitionV1 = text;
                    },
                    validationFunc: validateCommitionV1

                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5,top: 10),child: Text(_homeProvider.currentLang=="ar"?"مبلغ العمولة":"Commission amount"),),
                Container(

                    child: CustomTextFormField(

                        prefixIconIsImage: false,
                        onChangedFunc: (text){
                          _commitionV2 = text;
                        },
                        validationFunc: validateCommitionV2

                    ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5,top: 10),child: Text(_homeProvider.currentLang=="ar"?"البنك الذي تم التحويل إليه":"The bank to which the transfer was made"),),
                Container(

                    child: CustomTextFormField(

                        prefixIconIsImage: false,
                        onChangedFunc: (text){
                          _commitionV3 = text;
                        },
                        validationFunc: validateCommitionV3

                    ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5,top: 10),child: Text(_homeProvider.currentLang=="ar"?"أسم المحول":"Transfer name"),),
                Container(


                    child: CustomTextFormField(

                        prefixIconIsImage: false,
                        onChangedFunc: (text){
                          _commitionV4 = text;
                        },
                        validationFunc: validateCommitionV4

                    ))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5,top: 10),child: Text(_homeProvider.currentLang=="ar"?"البريد الإلكتروني":"Email"),),
                Container(
                    child: CustomTextFormField(

                        prefixIconIsImage: false,
                        onChangedFunc: (text){
                          _commitionV5 = text;
                        },
                        validationFunc: validateCommitionV5

                    ))
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5,top: 10),child: Text(_homeProvider.currentLang=="ar"?"رقم الإعلان":"Ad number"),),
                Container(
                    child: CustomTextFormField(

                        prefixIconIsImage: false,
                        onChangedFunc: (text){
                          _commitionV6 = text;
                        },
                        validationFunc: validateCommitionV6

                    ))
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30,bottom: 5,top: 10),child: Text(_homeProvider.currentLang=="ar"?"ملاحظات":"Notes"),),
                Container(

                    child: CustomTextFormField(

                      prefixIconIsImage: false,
                      onChangedFunc: (text){
                        _commitionV7 = text;
                      },


                    ))
              ],
            ),
            Padding(padding: EdgeInsets.all(8)),

            Text(_homeProvider.currentLang=="ar"?"ارفق صورة التحويل":"Attach the transfer photo"),
            Padding(padding: EdgeInsets.all(5)),
            Stack(
              children: <Widget>[
                GestureDetector(
                    onTap: (){
                      _settingModalBottomSheet4(context);
                    },
                    child: Container(
                      height: _height * 0.1,
                      width: _width*.20,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        border: Border.all(
                          color: hintColor.withOpacity(0.4),
                        ),
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: _imageFile4 != null
                          ?ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child:  Image.file(
                            _imageFile4,
                            // fit: BoxFit.fill,
                          ))
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/newadd.png'),

                        ],
                      ),
                    )),

                Positioned(
                    top: 0,
                    child: GestureDetector(
                      child: Icon(Icons.delete_forever),
                      onTap: (){
                        setState(() {

                          _imageFile4=null;

                        });
                      },
                    ))
              ],
            ),


            Container(
                margin: EdgeInsets.only(top: _height *0.02,bottom: _height *0.02),
                child: _buildSendBtn()
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildSendBtn() {
    return _isLoading
        ? Center(
      child:SpinKitFadingCircle(color: mainAppColor),
    )
        : CustomButton(
      btnLbl: _homeProvider.currentLang=="ar"?"دفع الرسوم":"Pay fees",
      onPressedFunction: () async {
        if (_formKey.currentState.validate()) {

          setState(() {
            _isLoading = true;
          });



          String fileName4 = (_imageFile4!=null)?Path.basename(_imageFile4.path):"";
          FormData formData = new FormData.fromMap({
            "commition_v1":  _commitionV1,
            "commition_v2":  _commitionV2,
            "commition_v3":  _commitionV3,
            "commition_v4":  _commitionV4,
            "commition_v5":  _commitionV5,
            "commition_v6":  _commitionV6,
            "commition_v7":  _commitionV7,
            "commition_type":"2",
            "imgURL": (_imageFile4!=null)?await MultipartFile.fromFile(_imageFile4.path, filename: fileName4):""
          });

          final results = await _apiProvider
              .postWithDio(Urls.PAY_COMMISSION_URL + "?api_lang=${_authProvider.currentLang}", body: formData);
          setState(() => _isLoading = false);


          if (results['response'] == "1") {
            Commons.showToast(context, message:results["message"]);
            Navigator.pop(context);


          } else {
            Commons.showError(context, results["message"]);

          }

        }
      },
    );
  }





  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);
      _commisssionAppProvider = Provider.of<CommisssionAppProvider>(context);
      _commissionApp = _commisssionAppProvider.getCommissionApp();
      _initialRun = false;
    }
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
                  decoration: new BoxDecoration(

                    color: mainAppColor
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Consumer<AuthProvider>(
                          builder: (context,authProvider,child){
                            return authProvider.currentLang == 'ar' ? Image.asset(
                              'assets/images/back.png',

                            ): Transform.rotate(
                                angle: 180 * math.pi / 180,
                                child:  Image.asset(
                                  'assets/images/back.png',

                                ));
                          },
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      Text( _homeProvider.currentLang=="ar"?"طلب تمييز اعلان":"Request to star an ad",
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
