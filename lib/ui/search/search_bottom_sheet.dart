import 'package:flutter/cupertino.dart';
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
import 'package:naql/ui/search/search_screen.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({Key key}) : super(key: key);
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> with ValidationMixin
  {
  String _searchKey = '';
  String _priceFrom = '';
  String _priceTo = '';
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _subList;
  City _selectedCity;
  Country _selectedCountry;
  CategoryModel _selectedCategory;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  CategoryModel _selectedSub;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:true ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getSubList(enableSub: false,catId:_homeProvider.age!=''?_homeProvider.age:"6");

      _cityList = _homeProvider.getCityList(enableCountry: false);
      _initialRun = false;
    }
  }

  Widget build(BuildContext context) {


    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
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
                      AppLocalizations.of(context).translate('search_now'),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),

                SizedBox(height: 35,),

                Container(
                  width: constraints.maxWidth,

                  child: CustomTextFormField(
                    hintTxt: _homeProvider.currentLang=="ar"?"رقم الاعلان او عبارة البحث":"Ad number or search term",
                    onChangedFunc: (text) {
                      _searchKey = text;
                    },
                    validationFunc: validateAdPrice,
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.04),
                    child: FutureBuilder<List<CategoryModel>>(
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
                              hint: AppLocalizations.of(context).translate('choose_category'),
                              marg: .07,
                              onChangeFunc: (newValue) {
                                setState(() {
                                  _selectedCategory = newValue;
                                  _homeProvider.setAge(_selectedCategory.catId);
                                  _subList = _homeProvider.getSubList(enableSub: true,catId:_homeProvider.age!=''?_homeProvider.age:"6");

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
                    )),
                FutureBuilder<List<CategoryModel>>(
                  future: _subList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        var cityList = snapshot.data.map((item) {
                          return new DropdownMenuItem<CategoryModel>(
                            child: new Text(item.catName),
                            value: item,
                          );
                        }).toList();
                        cityList.removeAt(0);
                        return DropDownListSelector(
                          dropDownList: cityList,
                          hint: _homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub Category',
                          marg: .07,
                          onChangeFunc: (newValue) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              _selectedSub = newValue;
                              _homeProvider.setEnableSearch(true);
                              _homeProvider.setSelectedSub(_selectedSub);
                            });
                          },
                          value: _selectedSub,
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
                  margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.04),
                  child: FutureBuilder<List<City>>(
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
                            hint: AppLocalizations.of(context).translate('choose_city'),
                            onChangeFunc: (newValue) {
                              setState(() {
                                _selectedCity = newValue;
                              });
                            },
                            value: _selectedCity,
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
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth*.43,

                        child: InkWell(
                          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                          child: CustomTextFormField(
                              hintTxt: _homeProvider.currentLang=="ar"?"السعر يبدء من":"Price from",

                              onChangedFunc: (String text) {
                                _priceFrom = text;
                              }),
                        ),
                      ),

                      Container(
                        width: constraints.maxWidth*.43,
                        child: InkWell(
                          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                          child: CustomTextFormField(
                              hintTxt: _homeProvider.currentLang=="ar"?"السعر الى":"Price To",

                              onChangedFunc: (String text) {
                                _priceTo = text;
                              }),
                        ),
                      ),

                    ],
                  ),
                ),





                CustomButton(
                  btnLbl:  AppLocalizations.of(context).translate('search'),
                  onPressedFunction: () {
                 if (
checkSearchValidation(context,
searchCategory: _selectedCategory)){
   _homeProvider.setEnableSearch(true);
                    _homeProvider.setSearchKey(_searchKey);
                    _homeProvider.setPriceFrom(_priceFrom);
                    _homeProvider.setPriceTo(_priceTo);
                    _homeProvider.updateSelectedCategory(_selectedCategory);
                    _homeProvider.setSelectedSub(_selectedSub);
                     _homeProvider.setSelectedCity(_selectedCity);
                     Navigator.pop(context);
   Navigator.pushReplacement(
       context,
       MaterialPageRoute(
           builder: (context) =>
               SearchScreen()));
}
                   
                  },
                ),
              ]),
            ),
          ));
    });
  }
}
