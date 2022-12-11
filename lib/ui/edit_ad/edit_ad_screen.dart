import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:naql/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/ad.dart';
import 'package:naql/models/category.dart';
import 'package:naql/models/city.dart';
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
import 'package:path/path.dart' as Path;
import 'dart:math' as math;

class EditAdScreen extends StatefulWidget {
  final Ad ad;

  const EditAdScreen({Key key, this.ad}) : super(key: key);

  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  City _selectedCity;
  CategoryModel _selectedCategory;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  List<String> _genders ;
  String _selectedGender;
  File _imageFile;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  dynamic _pickImageError;
  final _picker = ImagePicker();
  AuthProvider _authProvider;
  ApiProvider _apiProvider = ApiProvider();
  bool _isLoading = false;
  String _adsTitle = '', _adsPrice = '', _adsDescription = '';
  String _adsPhone = '';
  String _adsWhatsapp = '';
  bool _initSelectedCity = true,
      _initSelectedCategory = true,
      _initSelectedKind = true;
  LocationData _locData;

  Future<void> _getCurrentUserLocation() async {
    _locData = await Location().getLocation();
    if(_locData != null){
      Commons.showToast(context, message:  AppLocalizations.of(context).translate('detect_location'));
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed1(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile1 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed2(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile2 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed3(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile3 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _genders = [AppLocalizations.of(context).translate('male'),
        AppLocalizations.of(context).translate('female'),
        AppLocalizations.of(context).translate('undefined')];
      _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('total'),catImage: 'assets/images/all.png'),enableSub: false);
      _cityList = _homeProvider.getCityList(enableCountry: false);
      _adsTitle = widget.ad.adsTitle;
      _adsPrice = widget.ad.adsPrice;
      _adsPhone = widget.ad.adsPhone;
      _adsWhatsapp = widget.ad.adsWhatsapp;
      _adsDescription = widget.ad.adsDetails;
      _initialRun = false;
    }
  }



  void _settingModalBottomSheet(context){
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
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.camera,
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


  void _settingModalBottomSheet1(context){
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
                      _onImageButtonPressed1(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed1(ImageSource.camera,
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


  void _settingModalBottomSheet2(context){
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
                      _onImageButtonPressed2(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed2(ImageSource.camera,
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


  void _settingModalBottomSheet3(context){
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
                      _onImageButtonPressed3(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed3(ImageSource.camera,
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


  Widget _buildBodyItem() {
    var genders = _genders.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25,5,25,10),
              child: Text(_homeProvider.currentLang=='ar'?"صور الاعلان":"Ad photos"),
            ),


            Row(
              children: <Widget>[
                Padding(padding:EdgeInsets.fromLTRB(25,5,5,10)),
                GestureDetector(
                    onTap: (){
                      _settingModalBottomSheet(context);
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
                      child: _imageFile != null
                          ?ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child:  Image.file(
                            _imageFile,
                            // fit: BoxFit.fill,
                          ))
                          :Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/newadd.png'),

                        ],
                      ),
                    )),



              ],

            ),


            Padding(padding: EdgeInsets.all(5)),

            Row(
              children: <Widget>[
                Padding(padding:EdgeInsets.fromLTRB(25,5,5,10)),
                widget.ad.adsPhoto11!=""?Container(
                  height: _height * 0.1777,
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
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.ad.adsPhoto11,
                            height: 100,

                          )),
                      GestureDetector(
                        child: Text("حذف"),
                        onTap: () async{


                          setState(() {
                            _isLoading = true;
                          });
                          final results =
                          await _apiProvider.post(
                              "https://naql-app.com/api/do_delete_photo" +
                                  "?id=${widget.ad.adsPhoto11}&api_lang=${_authProvider.currentLang}");

                          setState(() =>
                          _isLoading = false);
                          if (results['response'] ==
                              "1") {
                            Commons.showToast(context,
                                message: results[
                                "message"]);

                            Navigator
                                .pushReplacementNamed(
                                context,
                                '/my_ads_screen');

                          } else {
                            Commons.showError(context,
                                results["message"]);
                          }


                        },
                      )
                    ],
                  ),
                ):Text(""),

                Padding(padding: EdgeInsets.all(5)),

                widget.ad.adsPhoto22!=""? Container(
                  height: _height * 0.1777,
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
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.ad.adsPhoto22,
                            height: 100,

                          )),
                      GestureDetector(
                        child: Text("حذف"),
                        onTap: () async{


                          setState(() {
                            _isLoading = true;
                          });
                          final results =
                          await _apiProvider.post(
                              "https://naql-app.com/api/do_delete_photo" +
                                  "?id=${widget.ad.adsPhoto22}&api_lang=${_authProvider.currentLang}");

                          setState(() =>
                          _isLoading = false);
                          if (results['response'] ==
                              "1") {
                            Commons.showToast(context,
                                message: results[
                                "message"]);

                            Navigator
                                .pushReplacementNamed(
                                context,
                                '/my_ads_screen');

                          } else {
                            Commons.showError(context,
                                results["message"]);
                          }


                        },
                      )
                    ],
                  ),
                ):Text(""),

                Padding(padding: EdgeInsets.all(5)),

                widget.ad.adsPhoto33!=""? Container(
                  height: _height * 0.1777,
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
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.ad.adsPhoto33,
                            height: 100,

                          )),
                      GestureDetector(
                        child: Text("حذف"),
                        onTap: () async{


                          setState(() {
                            _isLoading = true;
                          });
                          final results =
                          await _apiProvider.post(
                              "https://naql-app.com/api/do_delete_photo" +
                                  "?id=${widget.ad.adsPhoto33}&api_lang=${_authProvider.currentLang}");

                          setState(() =>
                          _isLoading = false);
                          if (results['response'] ==
                              "1") {
                            Commons.showToast(context,
                                message: results[
                                "message"]);

                            Navigator
                                .pushReplacementNamed(
                                context,
                                '/my_ads_screen');

                          } else {
                            Commons.showError(context,
                                results["message"]);
                          }


                        },
                      )
                    ],
                  ),
                ):Text(""),

                Padding(padding: EdgeInsets.all(5)),

                widget.ad.adsPhoto44!=""?Container(
                  height: _height * 0.1777,
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
                  child:Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.ad.adsPhoto44,
                            height: 100,

                          )),
                      GestureDetector(
                        child: Text("حذف"),
                        onTap: () async{


                          setState(() {
                            _isLoading = true;
                          });
                          final results =
                          await _apiProvider.post(
                              "https://naql-app.com/api/do_delete_photo" +
                                  "?id=${widget.ad.adsPhoto44}&api_lang=${_authProvider.currentLang}");

                          setState(() =>
                          _isLoading = false);
                          if (results['response'] ==
                              "1") {
                            Commons.showToast(context,
                                message: results[
                                "message"]);

                            Navigator
                                .pushReplacementNamed(
                                context,
                                '/my_ads_screen');

                          } else {
                            Commons.showError(context,
                                results["message"]);
                          }


                        },
                      )
                    ],
                  ),
                ):Text(""),

              ],

            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                initialValue: _adsTitle,
                hintTxt: AppLocalizations.of(context).translate('ad_title'),
                onChangedFunc: (text) {
                  _adsTitle = text;
                },
                validationFunc: validateAdTitle,
              ),
            ),
            FutureBuilder<List<CategoryModel>>(
              future: _categoryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<CategoryModel>(
                        child: new Text(item.catName),
                        value: item,
                      );
                    }).toList();
                    if (_initSelectedCategory) {
                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (widget.ad.adsCatName == snapshot.data[i].catName) {
                          _selectedCategory = snapshot.data[i];
                          break;
                        }
                      }
                      _initSelectedCategory = false;
                    }

                    return DropDownListSelector(
                      marg: .06,
                      dropDownList: categoryList,
                      hint: AppLocalizations.of(context).translate('choose_category'),
                      onChangeFunc: (newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      value: _selectedCategory,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
            ),
            FutureBuilder<List<City>>(
              future: _cityList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var cityList = snapshot.data.map((item) {
                    return new DropdownMenuItem<City>(
                      child: new Text(item.cityName),
                      value: item,
                    );
                  }).toList();

                  if (_initSelectedCity) {

                    for (int i = 0; i < snapshot.data.length; i++) {
                      if (widget.ad.adsCityName == snapshot.data[i].cityName) {
                        _selectedCity = snapshot.data[i];
                        break;
                      }
                    }
                    _initSelectedCity = false;


                  }
                  return DropDownListSelector(
                    marg: .06,
                    dropDownList: cityList,
                    hint:  AppLocalizations.of(context).translate('choose_city'),
                    onChangeFunc: (newValue) {
                      setState(() {
                        _selectedCity = newValue;
                      });
                    },
                    value: _selectedCity,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: CustomTextFormField(
                initialValue: _adsPrice,
                hintTxt:  AppLocalizations.of(context).translate('ad_price'),
                onChangedFunc: (text) {
                  _adsPrice = text;
                },
                validationFunc: validateAdPrice,
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                initialValue: _adsPhone,
                hintTxt: _homeProvider.currentLang=="ar"?"رقم الجوال":"Phone",
                onChangedFunc: (text) {
                  _adsPhone = text;
                },
                validationFunc: validateAdTitle,
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                initialValue: _adsWhatsapp,
                hintTxt: _homeProvider.currentLang=="ar"?"رقم الواتساب":"Whatsapp",
                onChangedFunc: (text) {
                  _adsWhatsapp = text;
                },
                validationFunc: validateAdTitle,
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: CustomTextFormField(
                initialValue: _adsDescription,
                maxLines: 3,
                hintTxt: AppLocalizations.of(context).translate('ad_description'),
                validationFunc: validateAdDescription,
                onChangedFunc: (text) {
                  _adsDescription = text;
                },
              ),
            ),


            CustomButton(
              btnLbl: AppLocalizations.of(context).translate('save_edit'),
              onPressedFunction: () async {
                if (_formKey.currentState.validate() &
                checkEditAdValidation(context,

                    adMainCategory: _selectedCategory,
                    adCity: _selectedCity,
                    adKind: _selectedGender)) {
                  setState(() => _isLoading = true);
                  FormData formData ;
                  if(_imageFile != null){
                    String fileName = Path.basename(_imageFile.path);
                    String fileName1 = _imageFile1!=null?Path.basename(_imageFile1.path):"";
                    String fileName2 = _imageFile2!=null?Path.basename(_imageFile2.path):"";
                    String fileName3 = _imageFile3!=null?Path.basename(_imageFile3.path):"";
                    formData = new FormData.fromMap({
                      "ad_id":widget.ad.adsId,
                      "user_id": _authProvider.currentUser.userId,
                      "ads_title": _adsTitle,
                      "ads_details": _adsDescription,
                      "ads_cat": _selectedCategory.catId,
                      // 'ads_gender': _selectedGender,
                      "ads_phone": _adsPhone,
                      "ads_whatsapp": _adsWhatsapp,
                      "ads_city": _selectedCity.cityId,
                      // "ads_price": _adsPrice,
                      "ads_location":_locData!=null?'${_locData.latitude},${_locData.longitude}':"",
                      "imgURL[0]": await MultipartFile.fromFile(_imageFile.path,
                          filename: fileName),
                      "imgURL[1]": _imageFile1!=null?await MultipartFile.fromFile(_imageFile1.path,
                          filename: fileName1):"",
                      "imgURL[2]": _imageFile2!=null?await MultipartFile.fromFile(_imageFile2.path,
                          filename: fileName2):"",
                      "imgURL[3]": _imageFile3!=null?await MultipartFile.fromFile(_imageFile3.path,
                          filename: fileName3):"",
                    });
                  }
                  else{
                    formData = new FormData.fromMap({
                      "ad_id":widget.ad.adsId,
                      "user_id": _authProvider.currentUser.userId,
                      "ads_title": _adsTitle,
                      "ads_details": _adsDescription,
                      "ads_cat": _selectedCategory.catId,
                      // 'ads_gender': _selectedGender,
                      "ads_phone": _adsPhone,
                      "ads_whatsapp": _adsWhatsapp,
                      "ads_city": _selectedCity.cityId,
                      "ads_price": _adsPrice,
                      "ads_location":_locData!=null?'${_locData.latitude},${_locData.longitude}':"",

                    });

                  }

                  final results = await _apiProvider
                      .postWithDio(Urls.EDIT_AD_URL+ "?api_lang=${_authProvider.currentLang}", body: formData);
                  setState(() => _isLoading = false);

                  if (results['response'] == "1") {
                    Commons.showToast(context, message:results["message"]);

                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/my_ads_screen');

                  } else {
                    Commons.showError(context, results["message"]);
                  }
                }
              },
            ),
          ],
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
                      Text( AppLocalizations.of(context).translate('ad_edit'),
                          style: Theme.of(context).textTheme.headline1),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  )),
              _isLoading
                  ? Center(
                child: SpinKitFadingCircle(color: mainAppColor),
              )
                  : Container()
            ],
          )),
    );
  }
}
