import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/localization/FallbackCupertinoLocalisationsDelegate.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/page/WelcomePage.dart';
import 'package:snr/page/LoginPage.dart';
import 'package:snr/common/net/Code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/event/HttpErrorEvent.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snr/common/localization/MyLocalizationsDelegate.dart';
import 'package:snr/page/HomePage.dart';
import 'package:flutter/rendering.dart';
void main() {
  runApp(new SnrReduxApp());
  debugPaintSizeEnabled = false;
  debugPaintPointersEnabled = false;
  PaintingBinding.instance.imageCache.maximumSize = 100;
}

class SnrReduxApp extends StatelessWidget {
  ///創建Store，引用 SysState中的appReducer 實現 Reducer 方法
  ///initialState 初始化 State
  final store = new Store<SysState>(
    appReducer,
    ///初始化數據
    initialState: new SysState(
      userInfo: User.empty(),
      themeData: CommonUtils.getThemeData(Colors.blue),
      locale: Locale('zh','CH'),
      
    )
  );
  
  SnrReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<SysState>(builder: (context, store){
        return new MaterialApp(
          ///多語言delegate
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            MyLocalizationsDelegate.delegate,
            FallbackCupertinoLocalisationsDelegate(),
          ],
          locale: store.state.locale,
          supportedLocales: [store.state.locale],
          theme: store.state.themeData,
          routes: { 
            // 設定route path,app一開始先進入welcome page
              WelcomePage.sName: (context) {
                store.state.platfromLocale = Localizations.localeOf(context);
                return WelcomePage();
              },
              LoginPage.sName: (context) {//登入
                return new SNRLocalizations(
                  child: new LoginPage(),
                );
              },
              HomePage.sName: (context) {//主頁
                return new SNRLocalizations(
                  child: new HomePage(),
                );
              }

          },
        );
      }),
    );
  }
}

class SNRLocalizations extends StatefulWidget {
  final Widget child;

  SNRLocalizations({Key key, this.child}) : super(key: key);
    @override
    _SNRLocalizationsState createState() => _SNRLocalizationsState();
  }
  
  class _SNRLocalizationsState extends State<SNRLocalizations> {

    StreamSubscription stream;

    @override
    Widget build(BuildContext context) {

      return new StoreBuilder<SysState>(
        builder: (context, store) {
          return new Localizations.override(
            context: context,
            child: widget.child,
          );
        },
      );
    }
    @override
  void initState() {
    super.initState();
    stream =  Code.eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error);
        break;
      case 401:
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_401);
        break;
      case 403:
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_403);
        break;
      case 404:
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_404);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_timeout);
        break;
      default:
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_unknown + " " + message);
        break;
    }
  }
  }