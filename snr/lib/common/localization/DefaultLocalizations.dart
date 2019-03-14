import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStringBase.dart';
import 'package:snr/common/style/MyStringZh.dart';

///自定義多語言
class MyLocalizations {
  final Locale locale;

  MyLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///MyStringZh都继承了MyStringBase
  static Map<String, MyStringBase> _localizedValues = {
    'zh': new MyStringZh(),
  };

  MyStringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 MyLocalizations
  ///获取对应的 MyStringBase
  static MyLocalizations of(BuildContext context) {
    return Localizations.of(context, MyLocalizations);
  }
}
