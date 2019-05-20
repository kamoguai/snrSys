
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
import 'package:snr/widget/dialog/SmallPingTableItem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FinishedDetailPage extends StatefulWidget {


  @override
  _FinishedDetailPageState createState() => _FinishedDetailPageState();
}

class _FinishedDetailPageState extends State<FinishedDetailPage> with AutomaticKeepAliveClientMixin<FinishedDetailPage>, MyListState<FinishedDetailPage>, WidgetsBindingObserver {
 ///snr設定檔
  var config;
  ///現在按鈕enum
  var nowType = buttonType.day;
  ///hub
  var strHub = "";
  ///api傳入時間，0:完工,1:昨日,2:前日,3:大前,4:前前
  var day = "0";
  ///跳轉用
  var typeof = "";
  ///完工筆數
  var dayCount = "0";
  ///昨日筆數
  var day1Count = "0";
  ///前日筆數
  var day2Count = "0";
  ///大前日筆數
  var day3Count = "0";
  ///前前日筆數
  var day4Count = "0";
  /// user model
  User user;
  /// sso model
  Sso sso;
  ///跳轉客編arr
  final List<String> toTransformArray = [];
  ///數據資料arr
  final List<dynamic> dataArray = [];
  ///來自功能
  var fromFunc = "";
  ///列表顯示的物件
  _renderItem(index) {
    switch(nowType) {
      case buttonType.day:
        fromFunc = "DAY";
        break;
      case buttonType.day1:
        fromFunc = "DAY1";
        break;
      case buttonType.day2:
        fromFunc = "DAY2";
        break;
      case buttonType.day3:
        fromFunc = "DAY3";
        break;
      case buttonType.day4:
        fromFunc = "DAY4";
        break;
    }
    DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
    DefaultViewModel model = DefaultViewModel.forMap(dtc);
    return new DefaultTableItem(defaultViewModel: model, configData: config, addTransform: _addTransform, addTransformArray: toTransformArray, callPing: _callPing, currentCellTag: index, fromFunc: fromFunc,);
  }

  ///頁面上方按鈕群
  _renderHeader() {
    return Container(
      height: 55.0,
      padding: EdgeInsets.all(10.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
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
                  .text_finish + "-${dayCount}",
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.day ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.day;
                  day = "0";
                  showRefreshLoading();
                });
                
              },
            ),
          ),
          SizedBox(width: 10,),
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
                  .finished_day1 + "-${day1Count}",
              color: Color(MyColors.hexFromStr("#f0fcff")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.day1 ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.day1;
                  day = "1";
                  showRefreshLoading();
                });
              },
            ),
          ),
          SizedBox(width: 10,),
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
                  .finished_day2 + "-${day2Count}",
              color: Color(MyColors.hexFromStr("#fafff2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.day2 ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.day2;
                  day = "2";
                  showRefreshLoading();
                });
              },
            ),
          ),
          SizedBox(width: 10,),
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
                  .finished_day3 + "-${day3Count}",
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.day3 ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.day3;
                  day = "3";
                  showRefreshLoading();
                });
              },
            ),
          ),
          SizedBox(width: 10,),
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
                  .finished_day4 + "-${day4Count}",
              color: Color(MyColors.hexFromStr("#f2f2f2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowType == buttonType.day4 ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowType = buttonType.day4;
                  day = "4";
                  showRefreshLoading();
                });
              },
            ),
          ),
        ],
      )
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
    var res = await AssignFixDao.getFinishedFix(
    city: strCity,
    sort: strSort,
    hub: strHub,
    day: day,
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
    var res = await DefaultTableDao.getPingSNR(_getStore(),context, custCode: custCode);
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
        case buttonType.day: 
          if (this.toTransformArray.length >= 2) {
             sortArray = ["完工","拆改","觀察","自移"];
          }
          else {
            sortArray = ["完工","拆改","觀察","低HP","自移"];
          }
          break;
        case buttonType.day1: 
          if (this.toTransformArray.length >= 2) {
            sortArray = ["完工","自移"];
          }
          else {
            sortArray = ["完工","低HP","自移"];
          }
          break;
        case buttonType.day2:
          if (this.toTransformArray.length >= 2) {
            sortArray = ["完工","派修","觀察","自移"];
          }
          else {
            sortArray = ["完工","派修","觀察","低HP","自移"];
          }
          break;
        case buttonType.day3:
          if (this.toTransformArray.length >= 2) {
            sortArray = ["完工","派修","拆改","其他(可異)","無下行(超時)","正常","自移"];
          }
          else {
            sortArray = ["完工","派修","拆改","其他(可異)","低HP","無下行(超時)","正常","自移"];
          }
          break;
        case buttonType.day4:
        
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
                  style: TextStyle(color: Colors.black, ),
                  children: <TextSpan>[TextSpan(text: '${sortStr}', style: TextStyle(color: Colors.blue, )),]
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
                  style: TextStyle(fontSize: ScreenUtil().setSp(20)),
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
                  child: Text('確定', style: TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(20)),),
                ),
                CupertinoButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('取消', style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(20)),),
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
                  style: TextStyle(color: Colors.black, ),
                  children: <TextSpan>[TextSpan(text: '${sortStr}', style: TextStyle(color: Colors.blue, )),]
                ),
              ),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('取消', style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(20)),),
                ),
                CupertinoButton(
                  onPressed: (){
                    postTransferAPI(to);
                    Navigator.pop(context);
                  },
                  child: Text('確定', style: TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(20)),),
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
    });
  }
  ///小ping function
  void _callPing(String custCode, int currentCellTag) async{
    if (isLoading) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
      return;
    }
    isLoading = true;
    Fluttertoast.showToast(msg: '正在ping該筆資料中..');
    var res = await getPingData(custCode);
    if(res != null && res.result) {
      // var pingData = _getStore().state.pingData;
      showDialog(
      context: context,
      builder: (BuildContext context) => _buildPingDialog(context,res, currentCellTag: currentCellTag)
      );
      isLoading = false;
    }
    else {
      isLoading = false;
    }
    
  }
 ///小ping dialog
  Widget _buildPingDialog(BuildContext context, res, {currentCellTag}) {
    SmallPingTableCell sptc = SmallPingTableCell.fromJson(res.data);
    PingViewModel model = PingViewModel.forMap(sptc);
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: SmallPingTableItem(defaultViewModel: model, configData: config,),
          ),
          SizedBox(height: 20,),
         Card(
            color: Color(MyColors.hexFromStr("#ebf6f9")),
            child: ButtonTheme(
              minWidth: double.maxFinite,
              child: FlatButton(
                child: Text(CommonUtils.getLocale(context).text_leave, style: TextStyle(color: Colors.red, fontSize: MyScreen.homePageFontSize(context))),
                onPressed: (){
                  ///資料回填當前row cell
                  var pingRes = _getStore().state.pingtData;
                  var dic = pullLoadWidgetControl.dataList[currentCellTag];
                
                  setState(() {
                    
                    Map<String,dynamic> u = {};
                    Map<String, dynamic> snr = {};
                    if (pingRes.SNR != null) {
                      u = pingRes.SNR["U0"];
                      snr = u;
                      dic.U0_SNR = snr["SNR"];
                      dic.U0_PWR = snr["PWR"];
                      u = pingRes.SNR["U1"];
                      snr = u;
                      dic.U1_SNR = snr["SNR"];
                      dic.U1_PWR = snr["PWR"];
                      u = pingRes.SNR["U2"];
                      snr = u;
                      dic.U2_SNR = snr["SNR"];
                      dic.U2_PWR = snr["PWR"];
                      u = pingRes.SNR["U3"];
                      snr = u;
                      dic.U3_SNR = snr["SNR"];
                      dic.U3_PWR = snr["PWR"];
                    }
                    Map<String,dynamic> c = {};
                    u = pingRes.CodeWord["U0"];
                    c = u;
                    dic.U0U = c["U"];
                    dic.U0C = c["C"];
                    u = pingRes.CodeWord["U1"];
                    c = u;
                    dic.U1U = c["U"];
                    dic.U1C = c["C"];
                    u = pingRes.CodeWord["U2"];
                    c = u;
                    dic.U2U = c["U"];
                    dic.U2C = c["C"];
                    u = pingRes.CodeWord["U3"];
                    c = u;
                    dic.U3U = c["U"];
                    dic.U3C = c["C"];

                    dic.DS0 = pingRes.DS0;
                    dic.DS1 = pingRes.DS1;
                    dic.DS2 = pingRes.DS2;
                    dic.DS3 = pingRes.DS3;
                    dic.DS4 = pingRes.DS4;
                    dic.DS5 = pingRes.DS5;
                    dic.DS6 = pingRes.DS6;
                    dic.DS7 = pingRes.DS7;
                    dic.DP0 = pingRes.DP0;
                    dic.DP1 = pingRes.DP1;
                    dic.DP2 = pingRes.DP2;
                    dic.DP3 = pingRes.DP3;
                    dic.DP4 = pingRes.DP4;
                    dic.DP5 = pingRes.DP5;
                    dic.DP6 = pingRes.DP6;
                    dic.DP7 = pingRes.DP7;

                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
        ],
      ),
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
        dayCount = res.data["Day0"];
        day1Count = res.data["Day1"];
        day2Count = res.data["Day2"];
        day3Count = res.data["Day3"];

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
                      Text(CommonUtils.getLocale(context).text_finish, style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.yellow)),
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
                      textColor: Theme.of(context).primaryColor,
                      color: Colors.transparent,
                      fontSize: MyScreen.homePageFontSize(context),
                      onPress: () {},
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
  day,
  day1,
  day2,
  day3,
  day4,
}