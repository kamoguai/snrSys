import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snr/page/LoginPage.dart';
import 'package:snr/page/HomePage.dart';
import 'package:snr/page/abNormal/AbnormalCardPage.dart';
import 'package:snr/page/abNormal/AbnormalNodePage.dart';
import 'package:snr/page/abNormal/AbnormalDetailPage.dart';
import 'package:snr/page/assignFix/AssingFixDetailPage.dart';
import 'package:snr/page/assignFix/FinishedDetailPage.dart';
import 'package:snr/page/assignFix/FinishedManDetailPage.dart';
import 'package:snr/page/assignFix/FinishedStatisticPage.dart';
import 'package:snr/page/bigbad/BigbadDetailPage.dart';
import 'package:snr/page/bigbad/BigbadListPage.dart';
import 'package:snr/page/overpower/OverPowerDetailPage.dart';
import 'package:snr/page/overpower/OverPowerListPage.dart';
import 'package:snr/page/overpower/OverTimeDetailPage.dart';
import 'package:snr/page/problem/ProblemDetial.dart';
import 'package:snr/page/assignFix/AssignFixListPage.dart';
import 'package:snr/page/publicworks/PublicworksDetailPage.dart';
import 'package:snr/page/publicworks/PublicworksListPage.dart';
import 'package:snr/page/wrongPlace/WrongPlaceDetailPage.dart';

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
  ///一般跳轉頁面
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }
  ///跳轉至頁面並移除上一頁
  static NavigatorRemoveRouter(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, new CupertinoPageRoute(builder: (context) => widget), null);
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
  static goAbnormalDetail(BuildContext context, String cmtsCode, String cif, String node, String time) {
    NavigatorRouter(context,new AbnormalDetailPage(cmtsCode, cif, node, time));
  }
  ///問題詳情頁面
  static goProblemDetail(BuildContext context){
    NavigatorRouter(context,new ProblemDetailPage());
  }
  ///派修分析頁面
  static goAssignFixList(BuildContext context) {
    NavigatorRouter(context,new AssignFixListPage());
  }
  ///派修詳情頁面
  static goAssignFixDetail(BuildContext context){
    NavigatorRouter(context,new AssignFixDetailPage());
  }
  ///完工詳情頁面
  static goFinishedDetail(BuildContext context) {
    NavigatorRouter(context, new FinishedDetailPage());
  }
  ///完工統計頁面
  static goFinishedStatistic(BuildContext context) {
     NavigatorRouter(context, new FinishedStatisticPage());
  }
  ///完工扣點頁面
  static goFinishedManDetail(BuildContext context, {empName}) {
    NavigatorRouter(context, new FinishedManDetailPage(empName));
  }
  ///工務列表
  static goPublicworksList(BuildContext context) {
    NavigatorRouter(context, new PublicworksListPage());
  }
  ///工務詳情頁面
  static goPublicworksDetail(BuildContext context) {
    NavigatorRouter(context, new PublicworksDetailPage());
  }
  ///overpower列表頁面
  static goOverPowerList(BuildContext context) {
    NavigatorRouter(context, new OverPowerListPage());
  }
  ///overpower詳情頁面
  static goOverPowerDetail(BuildContext context) {
    NavigatorRouter(context, new OverPowerDetailPage());
  }
  ///overtime詳情頁面
  static goOverTimeDetail(BuildContext context, {dataType}) {
    NavigatorRouter(context, new OverTimeDetailPage(dataType));
  }
  ///重大列表頁面
  static goBigBadList(BuildContext context) {
    NavigatorRouter(context, new BigBadListPage());
  }
  ///重大詳情頁面
  static goBigBadDetail(BuildContext context) {
    NavigatorRouter(context, new BigBadDetailPage());
  }
  ///自宜詳情頁面
  static goWrongPlaceDetail(BuildContext context) {
    NavigatorRouter(context, new WrongPlaceDetailPage());
  }
}