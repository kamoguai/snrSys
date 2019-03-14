import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snr/common/localization/DefaultLocalizations.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';

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


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}