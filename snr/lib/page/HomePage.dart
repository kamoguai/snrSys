import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snr/common/localization/DefaultLocalizations.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyTabBarWidget.dart';

/**
 * 主頁
 * Date: 2018-03-14
 */
class HomePage extends StatelessWidget {
  static final String sName = "home";

  ///提示退出app
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text(CommonUtils.getLocale(context).app_back_tip),
              actions: <Widget>[
                new FlatButton(onPressed: () => Navigator.of(context).pop(false), child: new Text(CommonUtils.getLocale(context).app_cancel)),
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: new Text(CommonUtils.getLocale(context).app_ok))
              ],
            ));
  }

  /// tool bar 
  _renderTab(text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(text)
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(CommonUtils.getLocale(context).common_toolBar_refresh),
      _renderTab(CommonUtils.getLocale(context).common_toolBar_analyze),
      _renderTab(CommonUtils.getLocale(context).common_toolBar_set),
      _renderTab(CommonUtils.getLocale(context).common_toolBar_back),
    ];
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new MyTabBarWidget(
        type: MyTabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: <Widget>[

        ],
        backgroundColor: MyColors.primarySwatch,
        indicatorColor: Color(MyColors.white),
      ),      
    );
  }
}