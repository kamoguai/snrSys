

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AssignFixDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/FinishedTableCell.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/FinishedTableItem.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/model/SsoLogin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FinishedManDetailPage extends StatefulWidget {

  
  final String empName;
  FinishedManDetailPage(this.empName, {Key key}) : super(key: key);

  @override
  _FinishedManDetailPageState createState() => _FinishedManDetailPageState();
}

class _FinishedManDetailPageState extends State<FinishedManDetailPage> with AutomaticKeepAliveClientMixin<FinishedManDetailPage>, MyListState<FinishedManDetailPage>, WidgetsBindingObserver {
  ///snr設定檔
  var config;
  ///現在按鈕enum
  var nowType = buttonType.finished;
  ///hub
  var strHub = "";
  ///現在功能
  var typevalue = "0";
  ///同上
  var typeof = "CUT";
  ///完工筆數
  var finishedCount = "0";
  ///扣點筆數
  var bpCount = "0";
  ///重大筆數
  var bigbadCount = "0";
  ///區障筆數
  var pipeCount = "0";
  /// user model
  User user;
  /// sso model
  Sso sso;
  ///跳轉客編arr
  final List<String> toTransformArray = [];
  ///數據資料arr
  final List<dynamic> dataArray = [];
  ///列表顯示的物件
  _renderItem(index) {
    var nowTypeStr = "";
    switch(nowType) {
      case buttonType.finished: 
        nowTypeStr = "finished";
        break;
      case buttonType.bp:
        nowTypeStr = "bp";
        break;
      case buttonType.bigbad:
        nowTypeStr = "bigbad";
        break;
      case buttonType.pipe:
        nowTypeStr = "pipe";
        break;
    }
    FinishedTableCell dtc = pullLoadWidgetControl.dataList[index];
    FinishedViewModel model = FinishedViewModel.forMap(dtc);
    return new FinishedTableItem(defaultViewModel: model, nowType: nowTypeStr,);
  }

  ///頁面上方按鈕群
  _renderHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ButtonTheme(
            minWidth: MyScreen.default4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_finish + "-${finishedCount}",
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.finished ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.finished;
                  typevalue = "0";
                  typeof = "CUT";
                  showRefreshLoading();
                });
                
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.default4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_bp + "-${bpCount}",
              color: Color(MyColors.hexFromStr("#f0fcff")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.bp ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.bp;
                  typevalue = "1";
                  typeof = "FIX2";
                  showRefreshLoading();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.default4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .home_btn_bigbad + "-${bigbadCount}",
              color: Color(MyColors.hexFromStr("#fafff2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.bigbad ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.bigbad;
                  typevalue = "1";
                  typeof = "CUT";
                  showRefreshLoading();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.default4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_pipe + "-${pipeCount}",
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.pipe ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.pipe;
                  typevalue = "1";
                  typeof = "WATCH";
                  // showRefreshLoading();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  ///body view 
  _renderBody() {
    return MyPullLoadWidget(
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderItem(index),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
    );
  }

  ///取得使用者信息
  getUserInfoData() async {
    var res = await UserDao.getUserInfoLocal();
    user = res;
  }
  ///初始化
  initParam() async {
    var userRes = await UserDao.getUserInfoLocal();
    var ssoRes = await UserDao.getUserSSOInfoLocal();
    user = userRes.data;
    sso = ssoRes.data;
    user.accNo = await LocalStorage.get(Config.USER_NAME_KEY);
    user.accName = sso.accName;
    final configData = await LocalStorage.get(Config.SNR_CONFIG);
    final dic = json.decode(configData);
    config = dic;
  }
  ///get api data
  getApiDataList() async {
    // var res = await AssignFixDao.getAssignFix(_getStore(),
    // city: strCity,
    // sort: strSort,
    // hub: strHub,
    // typeOf: typeof,
    // typeValue: typevalue,
    // accNo: user.accNo,
    // );
    // return res;
  }
  
  Store<SysState> _getStore() {
    return StoreProvider.of(context);
  }

  //透過override pullcontroller裡面的handleRefresh覆寫數據
  @override
  Future<Null> handleRefresh() async {
    dataArray.clear();
    if (isLoading) {
      return null;
    }
    isLoading = true;
 
    var res = await getApiDataList();
    if (res != null && res.result) {
      List<FinishedTableCell> list = new List();
      
      dataArray.addAll(res.data["Data"]);
      if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(FinishedTableCell.fromJson(dic));
          }
      }
      setState(() {
        toTransformArray.clear();
        // pullLoadWidgetControl.dataList.clear();
        clearData();
        finishedCount = res.data["FIX"];
        bpCount = res.data["FIX2"];
        bigbadCount = res.data["CUT"];
        pipeCount = res.data["WATCH"];

        pullLoadWidgetControl.dataList.addAll(list);
        pullLoadWidgetControl.needLoadMore = false;
      });
    }
   
    isLoading = false;
    return null;
  }

  @override
  void initState() {
    super.initState();
    initParam();
  }

  @override
  void didChangeDependencies() {
    var list = _getStore().state.finishedList;
    pullLoadWidgetControl.dataList = list;
    if (pullLoadWidgetControl.dataList.length == 0) {
      setState(() {});
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (pullLoadWidgetControl.dataList.length != 0) {
        showRefreshLoading();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    clearData();
    
  }

  @override
  bool get isRefreshFirst => false;

  @override
  requestRefresh() async {
    return null;
  }

  @override
  requestLoadMore() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
    super.build(context);
    return SafeArea(
      top: false,
      child: StoreBuilder<SysState>(
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              leading: Container(),
              elevation: 0.0,
              actions: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: MyScreen.homePageBarButtonWidth(context),
                        child: new MyToolButton(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          text: widget.empName,
                          textColor: Colors.white,
                          color: Colors.transparent,
                          fontSize: MyScreen.normalPageFontSize(context),
                          onPress: () {
                           
                          },
                        ),
                      ),
                      SizedBox(),
                      Text(CommonUtils.getLocale(context).text_finish, style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.yellow)),
                      SizedBox(),
                      SizedBox(),
                      SizedBox(),
                      SizedBox(),
                      SizedBox(),
                      Text('筆數: ${pullLoadWidgetControl.dataList.length}', style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
            // body: _renderBody(),
            body: Column(
              children: <Widget>[
                _renderHeader(),
                buildLine(),
                Expanded(
                  child: _renderBody(),
                ),
                
              ],
            ),
            ///toolBar
            bottomNavigationBar: new Material(
              color: Theme.of(context).primaryColor,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: CommonUtils.getLocale(context).text_refresh,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        getApiDataList();
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: '',
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    child: FlatButton.icon(
                      icon: Image.asset('static/images/23.png'),
                      color: Colors.transparent,
                      label: Text(''),
                      onPressed: (){

                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: '',
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: CommonUtils.getLocale(context).text_back,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPress: () {
                        if (isLoading) {
                          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                          return;
                        }
                        clearData();
                        setState(() {
                          Navigator.pop(context);
                        });                    
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

enum buttonType {
  finished,
  bp,
  bigbad,
  pipe,
}