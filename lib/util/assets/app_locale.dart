import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocales {
  static const en = Locale('en', 'US');

  static Locale getCorrespondingLocal() {
    return [en].firstWhere((element) {
      return element.languageCode == Intl.systemLocale
          .split('_')
          .first;
    }, orElse: () => en);
  }

  static const path = 'assets/locales';
}

class LocaleTexts {
  static const appName = "app_name";
}
