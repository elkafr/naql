
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naql/utils/app_colors.dart';


ThemeData themeData() {
  return ThemeData(
      primaryColor: mainAppColor,
      hintColor: hintColor,
      brightness: Brightness.light,
      buttonColor: mainAppColor,
      accentColor: accentColor,
      scaffoldBackgroundColor: Color(0xffFFFFFF),
      fontFamily: 'Cairo',
      cursorColor: mainAppColor,
      textTheme: TextTheme(
        // app bar style
        headline1:
            TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),

        // title of dialog
        headline2: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w400),

        // hint style of text form
        headline3: TextStyle(
                    color: hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),

   

        button: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14.0),

      
      ));
}

