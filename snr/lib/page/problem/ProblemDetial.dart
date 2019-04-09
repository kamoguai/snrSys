import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/ProblemDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/page/problem/ProblemButtonController.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';

class ProblemDetailPage extends StatefulWidget {
  @override
  _ProblemDetailPageState createState() => _ProblemDetailPageState();
}

class _ProblemDetailPageState extends State<ProblemDetailPage> with AutomaticKeepAliveClientMixin<ProblemDetailPage>, MyListState<ProblemDetailPage> {

  var config;
  var nowType = buttonType.problem;
  var strArea = "";
  var strSort = "";
  var strHub = "";
  var typevalue = "1";
  var typeof = "PROBLEM";
  var vbadCount = "0";
  var problemCount = "0";
  var otherCount = "0";
  var traceCount = "0";
  User user;
  ///列表顯示的物件
  _renderItem(index) {
    DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
    DefaultViewModel model = DefaultViewModel.forMap(dtc);
    return new DefaultTableItem(model, config);
  }

  ///頁面上方按鈕群
  _renderHeader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ButtonTheme(
            minWidth: 70.0,
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_problem + "-${problemCount}",
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyConstant.smallTextSize,
              textColor: nowType == buttonType.problem ? Colors.red : Colors.grey[700],
              onPress: () {
                setState(() {
                  nowType = buttonType.problem;
                  typeof = "PROBLEM";
                  _reloadAction();
                });
                
              },
            ),
          ),
          ButtonTheme(
            minWidth: 70.0,
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_vbad + "-${vbadCount}",
              color: Color(MyColors.hexFromStr("#f0fcff")),
              fontSize: MyConstant.smallTextSize,
              textColor: nowType == buttonType.vbad ? Colors.red : Colors.grey[700],
              onPress: () {
                setState(() {
                  nowType = buttonType.vbad;
                  typeof = "VBAD";
                  _reloadAction();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: 70.0,
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_trace + "-${traceCount}",
              color: Color(MyColors.hexFromStr("#fafff2")),
              fontSize: MyConstant.smallTextSize,
              textColor: nowType == buttonType.trace ? Colors.red : Colors.grey[700],
              onPress: () {
                setState(() {
                  nowType = buttonType.trace;
                  typeof = "TRACK";
                  _reloadAction();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: 70.0,
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context)
                  .text_other + "-${otherCount}",
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyConstant.smallTextSize,
              textColor: nowType == buttonType.other ? Colors.red : Colors.grey[700],
              onPress: () {
                setState(() {
                  nowType = buttonType.other;
                  typeof = "OTHER";
                  _reloadAction();
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
  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///取得使用者信息
  getUserInfoData() async {
    var res = await UserDao.getUserInfoLocal();
    user = res;
    print("user data => ${user}");
  }
  ///初始化
  initParam() async {
    var res = await UserDao.getUserInfoLocal();
    user = res.data;
    user.accNo = await LocalStorage.get(Config.USER_NAME_KEY);
    final configData = await LocalStorage.get(Config.SNR_CONFIG);
    final dic = json.decode(configData);
    config = dic;
  }
  ///get api data
  getApiDataList() async {
    var res = await ProblemDao.getSNRProblemsAllBadSignal(_getStore(),
    city: strArea,
    sort: strSort,
    hub: strHub,
    typeOf: typeof,
    typeValue: typevalue,
    accNo: user.accNo,
    );
    return res;
  }

  _reloadAction() async {
    
    isLoading = showRefreshLoading();
    var res = await getApiDataList();
    if (res != null && res.result) {
      List<DefaultTableCell> list = new List();
      List<dynamic> dataArray = [];
      dataArray = res.data["Data"];
      if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(DefaultTableCell.fromJson(dic));
          }
      }
      setState(() {
        clearData();
        vbadCount = res.data["VBAD"];
        problemCount = res.data["PROBLEM"];
        otherCount = res.data["OTHER"];
        traceCount = res.data["TRACK"] == null ? "0" : res.data["TRACK"];

        pullLoadWidgetControl.dataList.addAll(list);
        pullLoadWidgetControl.needLoadMore = false;
      });
    }

    isLoading = false;
  }

  Store<SysState> _getStore() {
    return StoreProvider.of(context);
  }

  //透過override pullcontroller裡面的handleRefresh覆寫數據
  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    var res = await getApiDataList();
    if (res != null && res.result) {
      List<DefaultTableCell> list = new List();
      List<dynamic> dataArray = [];
      dataArray = res.data["Data"];
      if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(DefaultTableCell.fromJson(dic));
          }
      }
      setState(() {
        clearData();
        vbadCount = res.data["VBAD"];
        problemCount = res.data["PROBLEM"];
        otherCount = res.data["OTHER"];
        traceCount = res.data["TRACK"] == null ? "0" : res.data["TRACK"];

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
    var list = _getStore().state.defaultList;
    pullLoadWidgetControl.dataList = list;
    if (pullLoadWidgetControl.dataList.length == 0) {
      setState(() {});
      showRefreshLoading();
    }
    super.didChangeDependencies();
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
    super.build(context);
    return SafeArea(
      top: false,
      child: StoreBuilder<SysState>(
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              // flexibleSpace: _renderHeader(),
              backgroundColor: Theme.of(context).primaryColor,
              leading: Container(),
              elevation: 0.0,
            ),
            // body: _renderBody(),
            body: Column(
              children: <Widget>[
                _renderHeader(),
                _buildLine(),
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
                      text: "刷新",
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        isLoading = true;
                        setState(() {
                          
                        });
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: "分析",
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        print("123");
                      },
                    ),
                  ),
                  ButtonTheme(
                      child: new FlatButton.icon(
                    icon: Image.asset(
                      MyICons.DEFAULT_USER_ICON,
                      width: 30,
                      height: 30,
                    ),
                    textColor: Colors.white,
                    color: Colors.transparent,
                    label: Text(
                      'PING',
                      style: TextStyle(
                          fontSize: MyScreen.homePageFontSize(context)),
                    ),
                    onPressed: () {
                      print(123);
                    },
                  )),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: "設定",
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        print("123");
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: "返回",
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPress: () {
                        Navigator.pop(context);
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
  problem,
  vbad,
  trace,
  other,
}