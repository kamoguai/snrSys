
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AssignFixDao.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/model/SsoLogin.dart';
import 'package:snr/widget/SmallPingTableItem.dart';

class AssignFixDetailPage extends StatefulWidget {
  @override
  _AssignFixDetailPageState createState() => _AssignFixDetailPageState();
}

class _AssignFixDetailPageState extends State<AssignFixDetailPage> with AutomaticKeepAliveClientMixin<AssignFixDetailPage>, MyListState<AssignFixDetailPage>, WidgetsBindingObserver {
 ///snr設定檔
  var config;
  ///現在按鈕enum
  var nowType = buttonType.fix;
  ///hub
  var strHub = "";
  ///現在功能
  var typevalue = "0";
  ///同上
  var typeof = "CUT";
  ///派修筆數
  var fixCount = "0";
  ///再修筆數
  var fix2Count = "0";
  ///派拆筆數
  var cutCount = "0";
  ///觀察筆數
  var watchCount = "0";
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
    DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
    DefaultViewModel model = DefaultViewModel.forMap(dtc);
    return new DefaultTableItem(defaultViewModel: model, configData: config, addTransform: _addTransform, addTransformArray: toTransformArray, callPing: _callPing,);
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
                  .home_cmtsTitle_fix + "-${fixCount}",
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.fix ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.fix;
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
                  .text_fix2 + "-${fix2Count}",
              color: Color(MyColors.hexFromStr("#f0fcff")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.fix2 ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.fix2;
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
                  .text_cut + "-${cutCount}",
              color: Color(MyColors.hexFromStr("#fafff2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.cut ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.cut;
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
                  .text_watch + "-${watchCount}",
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.watch ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.watch;
                  typevalue = "1";
                  typeof = "WATCH";
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
    var res = await AssignFixDao.getAssignFix(_getStore(),
    city: strCity,
    sort: strSort,
    hub: strHub,
    typeOf: typeof,
    typeValue: typevalue,
    accNo: user.accNo,
    );
    return res;
  }
  /// call 跳轉api
  postTransferAPI(to) async {
    await DefaultTableDao.didTransfer(context, 
    to: to, 
    from: typeof,
    accNo: user.accNo,
    accName: user.accName,
    custCDList: toTransformArray
    );
    
    Future.delayed(const Duration(seconds: 1), () {
      showRefreshLoading();
    });
    
  }
  /// call 跳轉包含輸入匡api
  postTransferInputTextAPI(to, memo) async {
    await DefaultTableDao.didTransferInputText(context, 
    to: to, 
    from: typeof,
    memo: memo,
    accNo: user.accNo,
    accName: user.accName,
    custCDList: toTransformArray
    );
    
    Future.delayed(const Duration(seconds: 1), () {
      showRefreshLoading();
    });
    
  }
  ///呼叫小ping api
  getPingData(custCode) async {
    var res = await DefaultTableDao.getPingSNR(context, custCode: custCode);
    return res;
  }
  ///客編輸入匡
  _showQeuryCustNo(BuildContext context) {
    var custNo = "";
    Future.delayed(const Duration(seconds: 1), () {
      showDialog(
        context: context,
        builder: (context) {
          var dialog = CupertinoAlertDialog(
            title: Text("查詢"),
            content: Text('請輸入客編'),
            actions: <Widget>[
              CupertinoTextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, style: BorderStyle.solid)
                ),
                placeholder: '客編',
                onChanged: (String value){
                  setState(() {
                    custNo = value;
                  });
                },
              ),
              CupertinoButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('取消', style: TextStyle(color: Colors.red),),
              ),
              CupertinoButton(
                onPressed: (){
                  setState(() {
                      List<DefaultTableCell> list = new List();
                      pullLoadWidgetControl.dataList.clear();
                      for (var dic in dataArray) {
                        if (dic["CustNo"] == custNo) {
                          list.add(DefaultTableCell.fromJson(dic));
                        }
                      }
                      pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text('確定', style: TextStyle(color: Colors.blue),),
              ),
            ],
          );
          return dialog;
        }
      );
    });
  }

  var typeStr = "";
  ///執行跳轉action
  _transformDataAction(BuildContext context) {
    print("buttonTylpe => $nowType");
    if (user.isTransfer == 1) {
      if (toTransformArray.length < 1) {
        Fluttertoast.showToast(msg: '尚未選擇欲跳轉客編');
        return;
      }
      showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text('將選取的資轉'),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: _transSort()
          );
          return dialog;
        }
      );
    } 
  }
  ///跳轉裡的選項
  _transSort() {
    List<String> sortArray = [];
    List<Widget> wList = [];
      switch (nowType) {
        case buttonType.fix: 
          if (this.toTransformArray.length >= 2) {
             sortArray = ["完工","拆改","觀察","自移"];
          }
          else {
            sortArray = ["完工","拆改","觀察","低HP","自移"];
          }
          break;
        case buttonType.fix2: 
          if (this.toTransformArray.length >= 2) {
            sortArray = ["完工","自移"];
          }
          else {
            sortArray = ["完工","低HP","自移"];
          }
          break;
        case buttonType.cut:
          if (this.toTransformArray.length >= 2) {
            sortArray = ["完工","派修","觀察","自移"];
          }
          else {
            sortArray = ["完工","派修","觀察","低HP","自移"];
          }
          break;
        case buttonType.watch:
          if (this.toTransformArray.length >= 2) {
            sortArray = ["完工","派修","拆改","其他(可異)","無下行(超時)","正常","自移"];
          }
          else {
            sortArray = ["完工","派修","拆改","其他(可異)","低HP","無下行(超時)","正常","自移"];
          }
          break;
      }
      for (var sortStr in sortArray) {
        wList.add(
          CupertinoActionSheetAction(
            onPressed: () {
              switch (sortStr) {
                case "追蹤":
                    typeStr = "TRACK";
                    break;
                case "拆改":
                    typeStr = "CUT";
                    break;
                case "完工":
                    typeStr = "FINISH";
                    break;
                case "派修":
                    typeStr = "FIX";
                    break;
                case "可異":
                    typeStr = "VBAD";
                    break;
                case "NG":
                    typeStr = "NG";
                    break;
                case "觀察":
                    typeStr = "WATCH";
                    break;
                case "低HP":
                    typeStr = "LOWHP";
                    break;
                case "問題(可異)":
                    typeStr = "PROBLEM";
                    break;
                case "正常":
                    typeStr = "GOOD";
                    break;
                case "其他(可異)":
                    typeStr = "OTHER";
                    break;
                case "再修":
                    typeStr = "FIX2";
                    break;
                case "可優":
                    typeStr = "VBAD2";
                    break;
                case "無下行(超時)":
                    typeStr = "NODS";
                    break;
                case "自移":
                    typeStr = "WP2";
                  break;
                default:
                  break;
              }
              print("跳轉to -> $typeStr");
              Navigator.pop(context);
              _transformDialog(context, to: typeStr, sortStr: sortStr);
            },
            child: Text(sortStr),
          )
        );
      }
      return wList;
  }
  _transformDialog(BuildContext context, {to,sortStr}) {
    Future.delayed(const Duration(seconds: 1), () {
      if (sortStr == "低HP" || sortStr == "自移") {
        var memoText = "";
        showDialog(
          context: context,
          builder: (context) {
            var dialog = CupertinoAlertDialog(
              content: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '確定將選取的${toTransformArray.length}筆資料轉至\n', 
                  style: TextStyle(color: Colors.black, fontSize: MyScreen.defaultTableCellFontSize(context),),
                  children: <TextSpan>[TextSpan(text: '${sortStr}', style: TextStyle(color: Colors.blue, fontSize: MyScreen.defaultTableCellFontSize(context))),]
                ),
              ),
              // Text('確定將選取的${toTransformArray.length}筆資料轉至\n${sortStr}'),
              actions: <Widget>[
                CupertinoTextField(
                  autofocus: true,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey, style: BorderStyle.solid)
                  ),
                  placeholder: '備註為必填',
                  onChanged: (String value){
                    setState(() {
                      memoText = value;
                    });
                  },
                ),
                CupertinoButton(
                  onPressed: (){
                    if (memoText == "") {
                      Fluttertoast.showToast(msg: '備註為必填唷！');
                      return;
                    }
                    postTransferInputTextAPI(to, memoText);
                    Navigator.pop(context);
                  },
                  child: Text('確定', style: TextStyle(color: Colors.blue),),
                ),
                CupertinoButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('取消', style: TextStyle(color: Colors.red),),
                ),
                
              ],
            );
            return dialog;
          }
        );
      }
      else {
        showDialog(
          context: context,
          builder: (context) {
            var dialog = CupertinoAlertDialog(
              content: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '確定將選取的${toTransformArray.length}筆資料轉至\n', 
                  style: TextStyle(color: Colors.black, fontSize: MyScreen.defaultTableCellFontSize(context),),
                  children: <TextSpan>[TextSpan(text: '${sortStr}', style: TextStyle(color: Colors.blue, fontSize: MyScreen.defaultTableCellFontSize(context))),]
                ),
              ),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('取消', style: TextStyle(color: Colors.red),),
                ),
                CupertinoButton(
                  onPressed: (){
                    postTransferAPI(to);
                    Navigator.pop(context);
                  },
                  child: Text('確定', style: TextStyle(color: Colors.blue),),
                ),
              ],
            );
            return dialog;  
          }
        );
      }
    });
  } 
  ///跳轉function
  void _addTransform(String custNo) {
    setState(() {
      if (toTransformArray.contains(custNo)) {
        var index = toTransformArray.indexOf(custNo);
        toTransformArray.removeAt(index);
      }
      else {
        toTransformArray.add(custNo);
      }
      
      print("now custNo => $toTransformArray");
    });
  }
  void _callPing(String custCode) async{
    
    var res = await getPingData(custCode);
    if(res != null && res.result) {
      
      showDialog(
      context: context,
      builder: (BuildContext context) => _buildPingDialog(context,res)
      );
    }
    
  }
  Widget _buildPingDialog(BuildContext context, res) {
    SmallPingTableCell sptc = SmallPingTableCell.fromJson(res.data);
    // DefaultTableCell dtc = pullLoadWidgetControl.dataList[0];
    PingViewModel model = PingViewModel.forMap(sptc);
    return AlertDialog(
      title: null,
      content: SmallPingTableItem(defaultViewModel: model, configData: config,),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('離開'),
        )
      ],
    );
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
      List<DefaultTableCell> list = new List();
      
      dataArray.addAll(res.data["Data"]);
      if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(DefaultTableCell.fromJson(dic));
          }
      }
      setState(() {
        toTransformArray.clear();
        pullLoadWidgetControl.dataList.clear();
        fixCount = res.data["FIX"];
        fix2Count = res.data["FIX2"];
        cutCount = res.data["CUT"];
        watchCount = res.data["WATCH"];

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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: MyScreen.homePageBarButtonWidth(context),
                        child: new MyToolButton(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          text: strCity == "" ?  '區:' + CommonUtils.getLocale(context).text_all : strCity,
                          textColor: Colors.white,
                          color: Colors.transparent,
                          fontSize: MyScreen.normalPageFontSize(context),
                          onPress: () {
                            if (isLoading) {
                              Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                              return;
                            }
                            showCityAlertSheetController(context);
                          },
                        ),
                      ),
                      SizedBox(),
                      Text(CommonUtils.getLocale(context).home_cmtsTitle_fix, style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.yellow)),
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
                        if (isLoading) {
                          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                          return;
                        }
                        _transformDataAction(context);
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
                        showSortAlertSheetController(context);
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: CommonUtils.getLocale(context).text_finish,
                      textColor: Colors.yellow,
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
                      text: CommonUtils.getLocale(context).text_search,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {
                        if (isLoading) {
                          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                          return;
                        }
                        showSearchAlertSheetController(context,dataArray);
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
  fix,
  fix2,
  cut,
  watch,
}