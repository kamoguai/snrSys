import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/common/style/MyStyle.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var isUpdate = false;

  updateFunc() async {
    var res = await UserDao.isUpdateApp(context);
    setState(() {
      isUpdate = res;
    });
  }

  void initState() {
    super.initState();
    updateFunc();
  }
  bool hadInit = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(hadInit) {
      return ;
    }
    hadInit = true;
    ///防止多次進入
    Store<SysState> store = StoreProvider.of(context);
    ///取得store狀態
    CommonUtils.initStatusBarHeight(context);
    //計算bar高度
    new Future.delayed(const Duration(seconds: 2), () {
      //延遲2秒跳轉
      UserDao.initUserInfo(store).then((res) {
        if (isUpdate) {
          NavigatorUtils.goLogin(context);
        }
        else {
          // 將使用者信息去store查詢
          if (res != null && res.result) {
            NavigatorUtils.goHome(context);
          }
          else {
            NavigatorUtils.goLogin(context);
          }
        }
        return true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<SysState>(
      builder: (context, store){
        return new Container(
          color: Color(MyColors.hexFromStr("#eeeeee")),
          child: new Center(
            child: new Image(image: new AssetImage('static/images/welcomePic.png')),
          )
        );
      },
    );
  }
}