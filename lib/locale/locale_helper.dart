import 'dart:ui';

import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class LocaleHelper extends ChangeNotifier {
  LocaleChangeCallback onLocaleChanged;

  static final LocaleHelper _helper = new LocaleHelper._internal();
  factory LocaleHelper() {
    return _helper;
  }

LocaleHelper._internal();
}

LocaleHelper helper = new LocaleHelper();
