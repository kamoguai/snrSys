

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/BpDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/BpAnalyzeTableCell.dart';
import 'package:snr/common/model/BpTableCell.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/BpAnalyzeTableItem.dart';
import 'package:snr/widget/BpTableItem.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/model/SsoLogin.dart';

/**
 * 點數詳情頁面
 * Date: 2019-04-29
 */
class BpDetailPage extends StatefulWidget {
  @override
  _BpDetailPageState createState() => _BpDetailPageState();
}

class _BpDetailPageState extends State<BpDetailPage> with AutomaticKeepAliveClientMixin<BpDetailPage>, MyListState<BpDetailPage>, WidgetsBindingObserver {
  ///現在時間
  final nowTime = DateTime.now();
  ///snr設定檔
  var config;
  ///現在按鈕type
  var nowBtnType = buttonType.confirm;
  ///待確認筆數
  var confirmCount = "0";
  ///扣點筆數
  var bpCount = "0";
  ///小計總數
  var totalCount = 0;
  ///裝機總數
  var instCount = 0;
  ///維修總數
  var fixCount = 0;
  ///扣點總數
  var pointCount = 0;
  //所選日期
  var selectDate = formatDate(DateTime.now(), [yyyy,'-',mm]);
  ///是否是今日
  var isThisMonth = false;
  ///待確認，扣點page
  var bpPage = "1";
  /// user model
  User user;
  /// sso model
  Sso sso;
  ///數據資料arr
  final List<dynamic> dataArray = [];
  ///是否顯示統計列表
  var isEnableStatistic = false;
  ///來自功能
  var fromFunc = "";
  ///列表顯示的物件
  _renderItem(index) {
    switch(nowBtnType) {
      case buttonType.confirm:
        fromFunc = "CONFIRM";
        break;
      case buttonType.bp:
        fromFunc = "BP";
        break;
      default:
        break;
    }
    if (!isEnableStatistic) {
      var bpType;
      if(nowBtnType == buttonType.confirm) {
        bpType = "confirm";
      }
      else {
        bpType = "bp";
      }
      BpTableCell dtc = pullLoadWidgetControl.dataList[index];
      BpViewModel model = BpViewModel.forMap(dtc);
      return new BpTableItem(defaultViewModel: model,bpType: bpType, fromFunc: fromFunc,);
      
    }
    else {
      BpAnalyzeTableCell wptc = pullLoadWidgetControl.dataList[index];
      BpAnalyzeViewModel model = BpAnalyzeViewModel.forMap(wptc);
      return new BpAnalyzeTableItem(defaultViewModel: model,);

    }
    
  }
  ///appbar按鈕群
  _renderAppBarAction() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text(CommonUtils.getLocale(context).text_wkPoint, style: TextStyle(color: Colors.yellow, fontSize: MyScreen.normalPageFontSize(context))),
          ),
          SizedBox(),
          Container(
            child: Text(CommonUtils.getLocale(context).text_snrPoint, style: TextStyle(color: Colors.white,fontSize: MyScreen.normalPageFontSize(context))),
          ),
          SizedBox(),
          ButtonTheme(
            minWidth: MyScreen.homePageBarButtonWidth(context),
            child: new MyToolButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              text: selectDate + '▼',
              textColor: Colors.white,
              color: Colors.transparent,
              fontSize: MyScreen.normalPageFontSize(context),
              onPress: () {
                showSelectorDateSheetController(context);
              },
            ),
          ),
        ],
      ),
    );
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
                  .text_confirm + "-${confirmCount}",
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType == buttonType.confirm ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                clearData();
                setState(() {
                  isEnableStatistic = false;
                  nowBtnType = buttonType.confirm;
                  bpPage = "1";
                  var list = _getStore().state.bpList;
                  pullLoadWidgetControl.dataList = list;
                  if (pullLoadWidgetControl.dataList.length == 0) {
                    showRefreshLoading();
                  }
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
              textColor: nowBtnType == buttonType.bp ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                clearData();
                setState(() {
                  isEnableStatistic = false;
                  nowBtnType = buttonType.bp;
                  bpPage = "2";
                  var list = _getStore().state.bpList;
                  pullLoadWidgetControl.dataList = list;
                  if (pullLoadWidgetControl.dataList.length == 0) {
                    showRefreshLoading();
                  }
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
                  .text_bpAnalize ,
              color: Color(MyColors.hexFromStr("#fafff2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType == buttonType.list ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                clearData();
                setState(() {
                  isEnableStatistic = true;
                  nowBtnType = buttonType.list;
                  bpPage = "3";
                  var list = _getStore().state.bpaList;
                  pullLoadWidgetControl.dataList = list;
                  if (pullLoadWidgetControl.dataList.length == 0) {
                    showRefreshLoading();
                  }
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
              text: '',
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyScreen.normalListPageFontSize(context),
              onPress: () {
                
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
  ///日期選擇器
  showSelectorDateSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (context){
        var dialog = CupertinoActionSheet(
          title: Text('選擇日期'),
          cancelButton: CupertinoActionSheetAction(
            child: Text('取消'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: _selectorSort(),
        );
        return dialog;
      }
    );
  }
  ///alert 選項內容
  _selectorSort() {
    List<Widget> wList = [];
    for (var i=0; i< 5; i++) {
      var time = new DateTime(nowTime.year, nowTime.month - i,);
      var formatD = formatDate(time, [yyyy,'-',mm]);
      if (i == 0){
        formatD = '今月';
      }
      wList.add(
        CupertinoActionSheetAction(
          child: Text(formatD),
          onPressed: (){
            setState(() {
             if (i == 0) {
               formatD = formatDate(time, [yyyy,'-',mm]);
               isThisMonth = true;
             }
             else {
               isThisMonth = false;
             }
             selectDate = formatD;
            //  isLoading = true;
             showRefreshLoading();
            });
            Navigator.pop(context);
          },
        )
      );
    }
    return wList;
  }
 
   @override
   Widget autoTextSize(text, style) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  ///body
  Widget getBody() {
    Widget body;
    if(isEnableStatistic) {
      body = Column(
        children: <Widget>[
          _renderHeader(),
          buildLine(),
          Container(
            decoration: BoxDecoration(color: Color(MyColors.hexFromStr('#fef5f6')),border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey,style: BorderStyle.solid))),
            height: listHeight(),
            child: Row(
              children: <Widget>[
                Container(
                  width: (deviceWidth8() * 2) - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_people, TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_point, TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_total_s, TextStyle(color: Colors.black)),
                ),
                buildRedLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_inst, TextStyle(color: Colors.black)),
                ),
                buildRedLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_maintain, TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_assign, TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_bp, TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
          buildLine(),
          Expanded(
            child: _renderBody(),
          ),
          buildLine(),
          Container(
            decoration: BoxDecoration(color: Color(MyColors.hexFromStr('#f0fcff')),border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey,style: BorderStyle.solid))),
            height: listHeight(),
            child: Row(
              children: <Widget>[
                Container(
                  width: (deviceWidth8() * 2) - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_total + "${dataArray.length}人", TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_point, TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize("$totalCount", TextStyle(color: Colors.black)),
                ),
                buildRedLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize("$instCount", TextStyle(color: Colors.black)),
                ),
                buildRedLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize("$fixCount", TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize(CommonUtils.getLocale(context).text_assign, TextStyle(color: Colors.black)),
                ),
                buildLineHeight(),
                Container(
                  width: deviceWidth8() - 1,
                  child: autoTextSize("$pointCount", TextStyle(color: Colors.red)),
                ),
              ],
            ),
          )
        ],
      );
    }
    else {
      body = Column(
        children: <Widget>[
          _renderHeader(),
          buildLine(),
          Expanded(
            child: _renderBody(),
          ),
        ],
      );
    }
    return body;
  }
  Store<SysState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    initParam();
  }

  @override
  void didChangeDependencies() {
    if(isEnableStatistic) {
      var list = _getStore().state.bpaList;
      pullLoadWidgetControl.dataList = list;
      if (pullLoadWidgetControl.dataList.length == 0) {
        setState(() {});
        showRefreshLoading();
      }
    }
    else {
      var list = _getStore().state.bpList;
      pullLoadWidgetControl.dataList = list;
      if (pullLoadWidgetControl.dataList.length == 0) {
        setState(() {});
        showRefreshLoading();
      }
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

  ///初始化
  initParam() async {
    //進入時先disable頭按鈕
    isEnableStatistic = false;
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
  ///清除資料
  cleanData() {
    totalCount = 0;
    fixCount = 0;
    instCount = 0;
    pointCount = 0;
  }
  ///get api data
  getApiDataList() async {
    //自移之外
    if(!isEnableStatistic) {
      var res = await BpDao.getQueryDeductDetail(yeaMonth: selectDate, page: bpPage);
      return res;
    }
    else {
      var res = await BpDao.getQueryDeductAnalyse(yeaMonth: selectDate);
      return res;
    }
  }
  //透過override pullcontroller裡面的handleRefresh覆寫數據
  @override
  Future<Null> handleRefresh() async {
    dataArray.clear();
    if (isLoading) {
      return null;
    }
    isLoading = true;
    if(!isEnableStatistic) {
      //統計按鈕之外都call這
      var res = await getApiDataList();
      if (res != null && res.result) {
        List<BpTableCell> list = new List();
        if (res.data["Data"] != null && res.data["Data"] != []) {
          dataArray.addAll(res.data["Data"]);
          
        }
        if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(BpTableCell.fromJson(dic));
          }
        }
        setState(() {
          pullLoadWidgetControl.dataList.clear();
          clearData();

          pullLoadWidgetControl.dataList.addAll(list);
          pullLoadWidgetControl.needLoadMore = false;
        });
      }
    }
    else {
      cleanData();
      //統計按鈕call這
      var res = await getApiDataList();
      if (res != null && res.result) {
        List<BpAnalyzeTableCell> list = new List();
        if (res.data["Data"] != null) {
          dataArray.addAll(res.data["Data"]);
        }
        
        if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            totalCount += int.parse(dic["Total"]);
            fixCount += int.parse(dic["Fix"]);
            pointCount += int.parse(dic["Points"]);
            instCount += int.parse(dic['Inst']);
            list.add(BpAnalyzeTableCell.fromJson(dic));
          }
        }
        setState(() {
          pullLoadWidgetControl.dataList.clear();
          pullLoadWidgetControl.dataList.addAll(list);
          pullLoadWidgetControl.needLoadMore = false;
        });
      }
    }
    isLoading = false;
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
                _renderAppBarAction()
              ],
            ),
            body: getBody(),
            
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
                        if (isLoading) {
                          Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                          return;
                        }
                        showRefreshLoading();
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
  confirm,
  bp,
  list
}