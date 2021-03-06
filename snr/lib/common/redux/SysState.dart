import 'package:flutter/material.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/redux/UserRedux.dart';
import 'package:snr/common/redux/ThemeRedux.dart';
import 'package:snr/common/redux/LocaleReducer.dart';
/**
 * Redux全局State
 * Date: 2019-03-11
 */

///全局Redux store 的對象，保存State數據
class SysState {
  ///用戶信息
  User userInfo;

  ///用戶接收到的事件列表
  // List<Event> eventList = new List();\

  ///主題數據
  ThemeData themeData;

  ///語言
  Locale locale;

  ////當前手機平台默認語言
  Locale platfromLocale;

  ///構造方法
  SysState({this.userInfo, this.themeData,this.locale});
}
///創建 Reducer
///源碼中Reducer 是一個方法 typedef state Reducer<State>(State state, dynamic action);
///這裡自定義appReducer 用於創建store
SysState appReducer(SysState state, action) {
  return SysState(
    ///通過 UserReducdr 將 SysState 內的 userInfo 和 action 關聯在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通過 ThemeDataReducer 將 SysState 內的 themeData 和 action 關聯在一起
    themeData: ThemeDataReducer(state.themeData, action),

    ///通過 LocaleReducer 將 SysState 內的 locale 和 action 關聯在一起
    locale: LocaleReducer(state.locale, action),
  );
}