import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snr/page/LoginPage.dart';
import 'package:snr/page/HomePage.dart';
import 'package:snr/page/abNormal/AbnormalCardPage.dart';
import 'package:snr/page/abNormal/AbnormalNodePage.dart';
import 'package:snr/page/abNormal/AbnormalDetailPage.dart';

/**
 * 導航欄
 * Date: 2019-03-11
 */
class NavigatorUtils {
  ///替換
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切換無參數頁面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }

  ///登入頁
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  ///首頁
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  static goAbnormalCard(BuildContext context) {
    NavigatorRouter(context, new AbnormalCardPage());
  }

  static goAbnormalNode(BuildContext context) {
    Navigator.pushReplacementNamed(context, AbnormalNodePage.sName);
  }

  static goAbnormalDetail(BuildContext context) {
    Navigator.pushReplacementNamed(context, AbnormalDetialPage.sName);
  }
}