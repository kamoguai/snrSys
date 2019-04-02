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
  ///pushReplacementNamed需要由main.dart做導航
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }
  ///卡板頁面
  static goAbnormalCard(BuildContext context, String cmtsCode, String name, String time) {
    NavigatorRouter(context, new AbnormalCardPage(cmtsCode, name, time));
  }
  ///卡板node頁面
  static goAbnormalNode(BuildContext context, String cmtsCode, String cif, String name, String time) {
    // Navigator.pushReplacementNamed(context, AbnormalNodePage.sName);
    NavigatorRouter(context,new AbnormalNodePage(cmtsCode, cif, name, time));
  }
  ///卡板詳情頁面
  static goAbnormalDetail(BuildContext context) {
    NavigatorRouter(context,new AbnormalDetialPage());
  }
}