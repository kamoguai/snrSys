import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class _ProblemDetailPageState extends State<ProblemDetailPage> with AutomaticKeepAliveClientMixin<ProblemDetailPage>, MyListState<ProblemDetailPage>, WidgetsBindingObserver {

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
                  .text_problem + "-${problemCount}",
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.problem ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.problem;
                  typeof = "PROBLEM";
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
                  .text_vbad + "-${vbadCount}",
              color: Color(MyColors.hexFromStr("#f0fcff")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.vbad ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.vbad;
                  typeof = "VBAD";
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
                  .text_trace + "-${traceCount}",
              color: Color(MyColors.hexFromStr("#fafff2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.trace ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.trace;
                  typeof = "TRACK";
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
                  .text_other + "-${otherCount}",
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.other ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.other;
                  typeof = "OTHER";
                  showRefreshLoading();
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
  ///排序dialog, ios樣式
  _showSortAlertSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text(CommonUtils.getLocale(context).text_sort),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = 'T';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_time),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = 'A';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_address),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = 'B';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_building),
              ),
            ],
          );
          
          return dialog;
        }
    );
  }

  ///查詢dialog, ios樣式
  _showSearchAlertSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text(CommonUtils.getLocale(context).text_sort),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_custcode),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text('CH'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text('SNR'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_extranet),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_intranet),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_offline),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_offline),
              ),
            ],
          );
          
          return dialog;
        }
    );
  }

  ///地區dialog, ios樣式
  _showCityAlertSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text(CommonUtils.getLocale(context).text_sort),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strArea = '';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_all),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strArea = CommonUtils.getLocale(context).text_bq;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_bq),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = CommonUtils.getLocale(context).text_sc;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_sc),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = CommonUtils.getLocale(context).text_xz;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_xz),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = CommonUtils.getLocale(context).text_tc;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_tc),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = CommonUtils.getLocale(context).text_lu;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_lu),
              ),
            ],
          );
          
          return dialog;
        }
    );
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: MyScreen.homePageBarButtonWidth(context),
                        child: new MyToolButton(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          text: strArea == "" ?  '區:' + CommonUtils.getLocale(context).text_all : strArea,
                          textColor: Colors.white,
                          color: Colors.transparent,
                          fontSize: MyScreen.normalPageFontSize(context),
                          onPress: () {
                            if (isLoading) {
                              Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                              return;
                            }
                            _showCityAlertSheetController(context);
                          },
                        ),
                      ),
                      Text(CommonUtils.getLocale(context).text_problem, style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.yellow)),
                      Text('          ', style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.yellow)),
                    ],
                  ),
                )
              ],
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
                      text: CommonUtils.getLocale(context).text_transform,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        setState(() {
                          
                        });
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: CommonUtils.getLocale(context).text_sort,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        if (isLoading) {
                          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                          return;
                        }
                        _showSortAlertSheetController(context);
                      
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
                      text: CommonUtils.getLocale(context).text_search,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        if (isLoading) {
                          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                          return;
                        }
                        _showSearchAlertSheetController(context);
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
  problem,
  vbad,
  trace,
  other,
}