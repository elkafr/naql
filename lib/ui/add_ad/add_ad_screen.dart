import 'dart:io';

import 'package:dio/dio.dart';
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




class AddAdScreen extends StatefulWidget {
  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  Future<List<Country>> _countryList;
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _subList;
  Country _selectedCountry;
  City _selectedCity;
  CategoryModel _selectedCategory;
  CategoryModel _selectedSub;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  List<String> _genders ;
  File _imageFile;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  String _xx=null;

  bool checkedValue=false;

  Future<List<Marka>> _markaList;
  Marka _selectedMarka;

  Future<List<Model>> _modelList;
  Model _selectedModel;


  dynamic _pickImageError;
  final _picker = ImagePicker();
  AuthProvider _authProvider;
  ApiProvider _apiProvider =ApiProvider();
  bool _isLoading = false;
  String _adsTitle = '';
  String _adsPrice = '';
  String _adsPhone = '';
  String _adsWhatsapp = '';
  String _adsDescription = '';
  String _adsOutColor='';
  String _adsFuel='';
  String _adsCylinders='';
  String _adsSpeedometer='';
  String _adsInColor='';
  String _adsChairsType='';
  NavigationProvider _navigationProvider;
  LocationData _locData;

  List<String> _adsPropulsion;
  String _selectedAdsPropulsion;

  List<String> _adsOpenRoof;
  String _selectedAdsOpenRoof;

  List<String> _adsGps;
  String _selectedAdsGps;

  List<String> _adsBluetooth;
  String _selectedAdsBluetooth;

  List<String> _adsCd;
  String _selectedAdsCd;

  List<String> _adsDvd;
  String _selectedAdsDvd;

  List<String> _adsSensors;
  String _selectedAdsSensors;

  List<String> _adsGuarantee;
  String _selectedAdsGuarantee;

  List<String> _adsCamera;
  String _selectedAdsCamera;

  List<String> _adsGear;
  String _selectedAdsGear;

   Future<void> _getCurrentUserLocation() async {
     _locData = await Location().getLocation();
    if(_locData != null){
      print('lat' + _locData.latitude.toString());
      print('longitude' + _locData.longitude.toString());
      Commons.showToast(context, message:
        AppLocalizations.of(context).translate('detect_location'));
        setState(() {

        });
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

      _adsPropulsion = ["دفع امامي",
        "دفع خلفي"];

      _adsOpenRoof = ["نعم", "لا"];
      _adsGps = ["نعم", "لا"];
      _adsBluetooth = ["نعم", "لا"];
      _adsCd = ["نعم", "لا"];
      _adsDvd = ["نعم", "لا"];
      _adsSensors = ["نعم", "لا"];
      _adsGuarantee = ["نعم", "لا"];
      _adsCamera = ["نعم", "لا"];
      _adsGear = ["يدوي", "اتوماتك"];


      _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('total'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:'6');

      _countryList = _homeProvider.getCountryList();
      _cityList = _homeProvider.getCityList(enableCountry: true,countryId:'500');
      _markaList = _homeProvider.getMarkaList();
      _modelList = _homeProvider.getModelList();


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

    var adsPropulsion = _adsPropulsion.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsOpenRoof = _adsOpenRoof.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsGps = _adsGps.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsBluetooth = _adsBluetooth.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsCd = _adsCd.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsDvd = _adsDvd.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsSensors = _adsSensors.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsGuarantee = _adsGuarantee.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsCamera = _adsCamera.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsGear = _adsGear.map((item) {
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

                Stack(
                  children: <Widget>[
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
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/newadd.png'),

                            ],
                          ),
                        )),

                        Positioned(child: GestureDetector(
                          child: Icon(Icons.delete_forever),
                          onTap: (){
                           setState(() {
                             _imageFile=null;
                           });
                          },
                        ))
                  ],
                ),

                Padding(padding: EdgeInsets.all(5)),

               Stack(
                 children: <Widget>[
                   GestureDetector(
                       onTap: (){
                         _settingModalBottomSheet1(context);
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
                         child: _imageFile1 != null
                             ?ClipRRect(
                             borderRadius: BorderRadius.circular(8.0),
                             child:  Image.file(
                               _imageFile1,
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

                            _imageFile1=null;

                          });
                        },
                      ))
                 ],
               ),

                Padding(padding: EdgeInsets.all(5)),

               Stack(
                 children: <Widget>[
                   GestureDetector(
                       onTap: (){
                         _settingModalBottomSheet2(context);
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
                         child: _imageFile2 != null
                             ?ClipRRect(
                             borderRadius: BorderRadius.circular(8.0),
                             child:  Image.file(
                               _imageFile2,
                               // fit: BoxFit.fill,
                             ))
                             : Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Image.asset('assets/images/newadd.png'),

                           ],
                         ),
                       )),

                   Positioned(child: GestureDetector(
                     child: Icon(Icons.delete_forever),
                     onTap: (){
                        setState(() {
                          _imageFile2=null;
                        });
                     },
                   ))
                 ],
               ),

                Padding(padding: EdgeInsets.all(5)),

                Stack(
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          _settingModalBottomSheet3(context);
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
                          child: _imageFile3 != null
                              ?ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:  Image.file(
                                _imageFile3,
                                // fit: BoxFit.fill,
                              ))
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/newadd.png'),


                            ],
                          ),
                        )),
                    Positioned(child: GestureDetector(
                      child: Icon(Icons.delete_forever),
                      onTap: (){
                       setState(() {
                         _imageFile3=null;
                       });
                      },
                    ))
                  ],
                ),

              ],

            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),

              child: CustomTextFormField(
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
                    categoryList.removeAt(0);
                    return DropDownListSelector(
                      dropDownList: categoryList,
                      marg: .07,
                      hint: _homeProvider.currentLang=='ar'?'القسم الرئيسي':'Main category',
                      onChangeFunc: (newValue) {
                         FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {


                          _selectedCategory = newValue;
                          _selectedSub=null;
                          _homeProvider.setSelectedCat(newValue);
                          _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
                          AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:_homeProvider.selectedCat.catId);


                          _xx=_homeProvider.selectedCat.catId;
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
              margin: EdgeInsets.only(top: _height * 0.02),
            ),
            FutureBuilder<List<CategoryModel>>(
              future: _subList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<CategoryModel>(
                        child: new Text(item.catName),
                        value: item,
                      );
                    }).toList();
                    categoryList.removeAt(0);
                    return DropDownListSelector(
                      dropDownList: categoryList,
                      marg: .07,
                      hint:_homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub category',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedSub = newValue;
                        });
                      },
                      value: _selectedSub,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else    if (snapshot.hasError) {
                  DioError error = snapshot.error;
                  String message = error.message;
                  if (error.type == DioErrorType.CONNECT_TIMEOUT)
                    message = 'Connection Timeout';
                  else if (error.type ==
                      DioErrorType.RECEIVE_TIMEOUT)
                    message = 'Receive Timeout';
                  else if (error.type == DioErrorType.RESPONSE)
                    message =
                    '404 server not found ${error.response.statusCode}';
                  print(message);
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),

            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
          Container(

              child: CustomTextFormField(
                hintTxt:  AppLocalizations.of(context).translate('ad_price')+ " ( اختياري ) ",
                onChangedFunc: (text) {
                  _adsPrice = text;
                },

              ),
            ),


            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            Container(

              child: CustomTextFormField(
                hintTxt: _homeProvider.currentLang=="ar"?"رقم الجوال":"Phone",
                onChangedFunc: (text) {
                  _adsPhone = text;
                },
                validationFunc: validateUserPhone,
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            Container(

              child: CustomTextFormField(
                hintTxt:  _homeProvider.currentLang=="ar"?"للتواصل واتساب ( مثال : 966501234567 )":"whatsapp ( Ex: 966501234567 )",
                onChangedFunc: (text) {
                  _adsWhatsapp = text;
                },
                validationFunc: validateUserWhats,
              ),
            ),

            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):
            FutureBuilder<List<Marka>>(
              future: _markaList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var markaList = snapshot.data.map((item) {

                      return new DropdownMenuItem<Marka>(

                        child: new Text(item.markaName),
                        value: item,
                      );
                    }).toList();

                    return DropDownListSelector(
                      dropDownList: markaList,
                      marg: .07,
                      hint: _homeProvider.currentLang=='ar'?'الماركة':'Marka',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {


                          _selectedMarka = newValue;
                        });
                      },
                      value: _selectedMarka,
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

            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):

            FutureBuilder<List<Model>>(
              future: _modelList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var modelList = snapshot.data.map((item) {

                      return new DropdownMenuItem<Model>(

                        child: new Text(item.modelName),
                        value: item,
                      );
                    }).toList();

                    return DropDownListSelector(
                      dropDownList: modelList,
                      marg: .07,
                      hint: _homeProvider.currentLang=='ar'?'الموديل':'Model',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {


                          _selectedModel = newValue;
                        });
                      },
                      value: _selectedModel,
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





            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):Container(

              child: CustomTextFormField(
                hintTxt:_homeProvider.currentLang=="ar"?"اللون الخارجي":"Exterior color",
                onChangedFunc: (text) {
                  _adsOutColor = text;
                },
              ),
            ),






            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):Container(

              child: CustomTextFormField(
                hintTxt:_homeProvider.currentLang=="ar"?"نوع الوقود":"Fuel type",
                onChangedFunc: (text) {
                  _adsFuel = text;
                },
              ),
            ),



            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):Container(

              child: CustomTextFormField(
                hintTxt:_homeProvider.currentLang=="ar"?"عدد السليندرات":"The number of cylinders",
                onChangedFunc: (text) {
                  _adsCylinders = text;
                },
              ),
            ),




            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):Container(

              child: CustomTextFormField(
                hintTxt:_homeProvider.currentLang=="ar"?"العداد":"the counter",
                onChangedFunc: (text) {
                  _adsSpeedometer = text;
                },
              ),
            ),


            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):Container(

              child: CustomTextFormField(
                hintTxt:_homeProvider.currentLang=="ar"?"اللون من الداخل":"Color inside",
                onChangedFunc: (text) {
                  _adsInColor = text;
                },
              ),
            ),



            _xx!='7'?Text("",style: TextStyle(height: 0),):
            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            _xx!='7'?Text("",style: TextStyle(height: 0),):Container(

              child: CustomTextFormField(
                hintTxt:_homeProvider.currentLang=="ar"?"نوع الفرش":"Type of brushes",
                onChangedFunc: (text) {
                  _adsChairsType = text;
                },
              ),
            ),



            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsPropulsion,
                hint:  _homeProvider.currentLang=="ar"?"نوع الدفع":"Vehicle propulsion type",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsPropulsion = newValue;
                  });
                },
                value: _selectedAdsPropulsion,
              ),
            ),


            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsOpenRoof,
                hint:  _homeProvider.currentLang=="ar"?"فتحة السقف":"The sunroof of the car",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsOpenRoof = newValue;
                  });
                },
                value: _selectedAdsOpenRoof,
              ),
            ),



            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsGps,
                hint:  _homeProvider.currentLang=="ar"?"نظام الخرائط":"Maps system",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsGps = newValue;
                  });
                },
                value: _selectedAdsGps,
              ),
            ),






            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsBluetooth,
                hint:  _homeProvider.currentLang=="ar"?"بلوتوث":"Bluetooth",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsBluetooth = newValue;
                  });
                },
                value: _selectedAdsBluetooth,
              ),
            ),


            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsCd,
                hint:  _homeProvider.currentLang=="ar"?"سي دي":"Cd",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsCd = newValue;
                  });
                },
                value: _selectedAdsCd,
              ),
            ),


            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsDvd,
                hint:  _homeProvider.currentLang=="ar"?"دي في دي":"Dvd",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsDvd = newValue;
                  });
                },
                value: _selectedAdsDvd,
              ),
            ),



            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsSensors,
                hint:  _homeProvider.currentLang=="ar"?"الحساسات":"Sensors",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsSensors= newValue;
                  });
                },
                value: _selectedAdsSensors,
              ),
            ),


            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsGuarantee,
                hint:  _homeProvider.currentLang=="ar"?"داخل الضمان":"Within warranty",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsGuarantee= newValue;
                  });
                },
                value: _selectedAdsGuarantee,
              ),
            ),



            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsCamera,
                hint:  _homeProvider.currentLang=="ar"?"كاميرا":"Camera",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsCamera= newValue;
                  });
                },
                value: _selectedAdsCamera,
              ),
            ),


            _xx!='7'?Text("",style: TextStyle(height: 0),):  Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: DropDownListSelector(
                marg: .07,
                dropDownList: adsGear,
                hint:  _homeProvider.currentLang=="ar"?"مغير السرعة":"Speed changer",
                onChangeFunc: (newValue) {
                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() {
                    _selectedAdsGear= newValue;
                    print(newValue);
                  });
                },
                value: _selectedAdsGear,
              ),
            ),



            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            FutureBuilder<List<Country>>(
              future: _countryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var countryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<Country>(
                        child: new Text(item.countryName),
                        value: item,
                      );
                    }).toList();
                    return DropDownListSelector(
                      dropDownList: countryList,
                      marg: .07,
                      hint:  AppLocalizations.of(context).translate('choose_country'),
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedCountry = newValue;
                          _selectedCity=null;
                          _homeProvider.setSelectedCountry(newValue);
                          _cityList = _homeProvider.getCityList(enableCountry: true,countryId:_homeProvider.selectedCountry.countryId);
                        });
                      },

                      value: _selectedCountry,
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
              margin: EdgeInsets.only(top: _height * 0.02),
            ),
            FutureBuilder<List<City>>(
              future: _cityList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var cityList = snapshot.data.map((item) {
                      return new DropdownMenuItem<City>(
                        child: new Text(item.cityName),
                        value: item,
                      );
                    }).toList();
                    return DropDownListSelector(
                      dropDownList: cityList,
                      marg: .07,
                      hint:  AppLocalizations.of(context).translate('choose_city'),
                      onChangeFunc: (newValue) {
                         FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedCity = newValue;
                        });
                      },
                      value: _selectedCity,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else    if (snapshot.hasError) {
                  DioError error = snapshot.error;
                  String message = error.message;
                  if (error.type == DioErrorType.CONNECT_TIMEOUT)
                    message = 'Connection Timeout';
                  else if (error.type ==
                      DioErrorType.RECEIVE_TIMEOUT)
                    message = 'Receive Timeout';
                  else if (error.type == DioErrorType.RESPONSE)
                    message =
                    '404 server not found ${error.response.statusCode}';
                  print(message);
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                maxLines: 3,
                hintTxt:  AppLocalizations.of(context).translate('ad_description'),
                validationFunc: validateAdDescription,
                onChangedFunc: (text) {
                  _adsDescription = text;
                },
              ),
            ),







            CustomButton(
              btnLbl: AppLocalizations.of(context).translate('publish_ad'),
              onPressedFunction: () async {
                if (_formKey.currentState.validate() &
                    checkAddAdValidation(context,
                    imgFile: _imageFile,
                        adMainCategory: _selectedCategory,
                        adCity: _selectedCity)) {

                               FocusScope.of(context).requestFocus( FocusNode());
                             setState(() => _isLoading = true);
                               String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";
                               String fileName1 = (_imageFile1!=null)?Path.basename(_imageFile1.path):"";
                               String fileName2 = (_imageFile2!=null)?Path.basename(_imageFile2.path):"";
                               String fileName3 = (_imageFile3!=null)?Path.basename(_imageFile3.path):"";
                  FormData formData = new FormData.fromMap({
                    "user_id": _authProvider.currentUser.userId,
                    "ads_title": _adsTitle,
                    "ads_details": _adsDescription,
                    "ads_cat": _selectedCategory.catId,
                    "ads_sub": _selectedSub.catId,
                    "ads_marka": _selectedMarka!=null?_selectedMarka.markaId:"0",
                    "ads_model": _selectedModel!=null?_selectedModel.modelId:"0",
                    "ads_country": _selectedCountry!=null?_selectedCountry.countryId:"0",
                    "ads_city": _selectedCity.cityId,
                    "ads_price": _adsPrice,
                    "ads_phone": _adsPhone,
                    "ads_whatsapp": _adsWhatsapp,

                    "ads_cylinders": _adsCylinders.toString(),
                    "ads_dvd": _selectedAdsDvd=="نعم"?"1":"0",
                    "ads_out_color": _adsOutColor.toString(),
                    "ads_open_roof": _selectedAdsOpenRoof=="نعم"?"1":"0",
                    "ads_fuel": _adsFuel.toString(),
                    "ads_camera": _selectedAdsCamera=="نعم"?"1":"0",
                    "ads_gear": _selectedAdsGear=="اتوماتك"?"1":"0",
                    "ads_guarantee": _selectedAdsGuarantee=="نعم"?"1":"0",
                    "ads_speedometer": _adsSpeedometer.toString(),
                    "ads_propulsion": _selectedAdsPropulsion=="دفع خلفي"?"1":"0",
                    "ads_sensors": _selectedAdsSensors=="نعم"?"1":"0",
                    "ads_cd": _selectedAdsCd=="نعم"?"1":"0",
                    "ads_bluetooth": _selectedAdsBluetooth=="نعم"?"1":"0",
                    "ads_in_color": _adsInColor.toString(),
                    "ads_chairs_type": _adsChairsType.toString(),
                    "ads_gps": _selectedAdsGps=="نعم"?"1":"0",


                    "imgURL[0]": (_imageFile!=null)?await MultipartFile.fromFile(_imageFile.path, filename: fileName):"",
                    "imgURL[1]": (_imageFile1!=null)?await MultipartFile.fromFile(_imageFile1.path, filename: fileName1):"",
                    "imgURL[2]": (_imageFile2!=null)?await MultipartFile.fromFile(_imageFile2.path, filename: fileName2):"",
                    "imgURL[3]": (_imageFile3!=null)?await MultipartFile.fromFile(_imageFile3.path, filename: fileName3):""
                  });
                  final results = await _apiProvider
                      .postWithDio(Urls.ADD_AD_URL + "?api_lang=${_authProvider.currentLang}", body: formData);
                  setState(() => _isLoading = false);


                  if (results['response'] == "1") {

                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) {
                          return ConfirmationDialog(
                            title: AppLocalizations.of(context).translate('ad_has_published_successfully'),
                            message:
                                AppLocalizations.of(context).translate('ad_published_and_manage_my_ads'),
                          );
                        });
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                       Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/my_ads_screen');
                      _navigationProvider.upadateNavigationIndex(4);
                    });
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
    _navigationProvider = Provider.of<NavigationProvider>(context);
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
                  Text(AppLocalizations.of(context).translate('add_ad'),
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
