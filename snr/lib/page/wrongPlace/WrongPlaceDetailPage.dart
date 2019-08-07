
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/dao/WrongPlaceDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/model/WrongPlaceNodeTableCell.dart';
import 'package:snr/common/model/WrongPlaceTableCell.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/model/SsoLogin.dart';
import 'package:snr/widget/WrongPlaceNodeTableItem.dart';
import 'package:snr/widget/WrongPlaceTalbeItem.dart';
import 'package:snr/widget/dialog/SmallPingTableItem.dart';
import 'package:snr/widget/dialog/WrongPlaceDialog.dart';


class WrongPlaceDetailPage extends StatefulWidget {
  @override
  _WrongPlaceDetailPageState createState() => _WrongPlaceDetailPageState();
}

class _WrongPlaceDetailPageState extends State<WrongPlaceDetailPage> with AutomaticKeepAliveClientMixin<WrongPlaceDetailPage>, MyListState<WrongPlaceDetailPage>, WidgetsBindingObserver{
  ///snr設定檔
  var config;
  ///現在按鈕enum
  var nowType = buttonType.wp1;
  ///現在appbar按鈕enum
  var nowAppBarType = appBarBtnType.noplace;
  ///hub
  var strHub = "";
  ///現在功能
  var typevalue = "1";
  ///同上
  var typeof = "NONODE";
  ///錯誤筆數
  var wp1Count = "0";
  ///自移筆數
  var wp2Count = "0";
  ///停訊筆數
  var wp3Count = "0";
  ///是否顯示header按鈕
  var isEnableHeadBtns = false;
  ///詳情page
  var wpPage = "1";
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
      case buttonType.wp1:
        fromFunc = "WP1";
        break;
      case buttonType.wp2:
        fromFunc = "WP2";
        break;
      case buttonType.wp3:
        fromFunc = "WP3";
        break;
      default:
        break;

    }
    if (isEnableHeadBtns) {
      if(nowType != buttonType.statistic) {
        DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
        DefaultViewModel model = DefaultViewModel.forMap(dtc);
        return new DefaultTableItem(defaultViewModel: model, configData: config, addTransform: _addTransform, addTransformArray: toTransformArray, callPing: _callPing, currentCellTag: index, fromFunc: fromFunc,);
      }
      else {
        WrongPlaceNodeTableCell dtc = pullLoadWidgetControl.dataList[index];
        WrongPlaceNodeViewModel model = WrongPlaceNodeViewModel.forMap(dtc);
        return new WrongPlaceNodeTableItem(defaultViewModel: model,dataCount: pullLoadWidgetControl.dataList.length,);
      }
      
    }
    else {
      WrongPlaceTableCell wptc = pullLoadWidgetControl.dataList[index];
      WrongPlaceViewModel model = WrongPlaceViewModel.forMap(wptc);
      return new WrongPlaceTableItem(defaultViewModel: model, addTransform: _addTransform, addTransformArray: toTransformArray, currentCellTag: index, callRefreshAPI: _callRefreshAPI,);

    }
    
  }

  ///appbar按鈕群
  _renderAppBarAction() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth4(),
              child: MyToolButton(
              text: CommonUtils.getLocale(context).text_noPlace,
              fontSize: MyScreen.appBarFontSize(context),
              textColor: nowAppBarType == appBarBtnType.noplace ? Colors.yellow : Colors.white,
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              onPress: (){
                if(mounted) {
                  setState(() {
                    clearData();
                    isEnableHeadBtns = false;
                    nowAppBarType = appBarBtnType.noplace;
                    var list = _getStore().state.wrongPlaceList;
                    pullLoadWidgetControl.dataList = list;
                    if (pullLoadWidgetControl.dataList.length == 0) {
                      showRefreshLoading();
                    }
                  });
                }
              },
            ),
          ),
          Container(
            width: deviceWidth4(),
              child: MyToolButton(
              text: CommonUtils.getLocale(context).text_wp2,
              fontSize: MyScreen.appBarFontSize(context),
              textColor: nowAppBarType == appBarBtnType.wp2 ? Colors.yellow : Colors.white,
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              onPress: (){
                if(mounted) {
                  setState(() {
                    clearData();
                    isEnableHeadBtns = true;
                    nowAppBarType = appBarBtnType.wp2;
                    var list = _getStore().state.defaultList;
                    pullLoadWidgetControl.dataList = list;
                    if (pullLoadWidgetControl.dataList.length == 0) {
                      showRefreshLoading();
                    }
                  });
                }
              },
            ),
          ),
          Container(
            width: deviceWidth4(),
              child: MyToolButton(
              text: '',
              textColor: nowAppBarType == appBarBtnType.cm ? Colors.yellow : Colors.white,
              fontSize: MyScreen.appBarFontSize(context),
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              onPress: (){
                // if(mounted) {
                //   setState(() {
                //     clearData();
                //     isEnableHeadBtns = false;
                //     nowAppBarType = appBarBtnType.cm;
                //     var list = _getStore().state.wrongPlaceList;
                //     pullLoadWidgetControl.dataList = list;
                //     if (pullLoadWidgetControl.dataList.length == 0) {
                //       showRefreshLoading();
                //     }
                //   });
                // }
              },
            ),
          ),
          Container(
            width: deviceWidth4(),
              child: MyToolButton(
              text: '',
              textColor: nowAppBarType == appBarBtnType.stb ? Colors.yellow : Colors.white,
              fontSize: MyScreen.appBarFontSize(context),
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              onPress: (){
                // if(mounted) {
                //   setState(() {
                //     clearData();
                //     isEnableHeadBtns = false;
                //     nowAppBarType = appBarBtnType.stb;
                //     var list = _getStore().state.wrongPlaceList;
                //     pullLoadWidgetControl.dataList = list;
                //     if (pullLoadWidgetControl.dataList.length == 0) {
                //       showRefreshLoading();
                //     }
                //   });
                // }
              },
            ),
          ),
        ],
      ),
    );
  }

  ///頁面上方按鈕群
  _renderHeader() {
    if(isEnableHeadBtns) {
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
                    .text_wp1 + "-${wp1Count}",
                color: Color(MyColors.hexFromStr("#eeffef")),
                fontSize: MyScreen.normalListPageFontSize(context),
                textColor: nowType == buttonType.wp1 ? Colors.red : Colors.grey[700],
                onPress: () {
                  if (isLoading) {
                    Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                    return;
                  }
                  clearData();
                  setState(() {
                    nowType = buttonType.wp1;
                    wpPage = "1";
                    typeof = "WP1";
                    var list = _getStore().state.defaultList;
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
                    .text_wp2 + "-${wp2Count}",
                color: Color(MyColors.hexFromStr("#f0fcff")),
                fontSize: MyScreen.normalListPageFontSize(context),
                textColor: nowType == buttonType.wp2 ? Colors.red : Colors.grey[700],
                onPress: () {
                  if (isLoading) {
                    Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                    return;
                  }
                  clearData();
                  setState(() {
                    nowType = buttonType.wp2;
                    wpPage = "2";
                    typeof = "WP2";
                    var list = _getStore().state.defaultList;
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
                    .text_wp3 + "-${wp3Count}",
                color: Color(MyColors.hexFromStr("#fafff2")),
                fontSize: MyScreen.normalListPageFontSize(context),
                textColor: nowType == buttonType.wp3 ? Colors.red : Colors.grey[700],
                onPress: () {
                  if (isLoading) {
                    Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                    return;
                  }
                  clearData();
                  setState(() {
                    nowType = buttonType.wp3;
                    wpPage = "3";
                    typeof = "WP3";
                    var list = _getStore().state.defaultList;
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
                    .text_statistic,
                color: Color(MyColors.hexFromStr("#fef5f6")),
                fontSize: MyScreen.normalListPageFontSize(context),
                textColor: nowType == buttonType.statistic ? Colors.red : Colors.grey[700],
                onPress: () {
                  if (isLoading) {
                    Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                    return;
                  }
                  clearData();
                  setState(() {
                    nowType = buttonType.statistic;
                    typeof = "statistic";
                    var list = _getStore().state.wrongPlaceNodeList;
                    pullLoadWidgetControl.dataList = list;
                    if (pullLoadWidgetControl.dataList.length == 0) {
                      showRefreshLoading();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Container();
    }
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

  Widget autoTextSizeH(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _statisticHead() {
    if (isEnableHeadBtns && nowType == buttonType.statistic) {
      return Container(
        height: titleHeight() * 0.7,
        color: Color(MyColors.hexFromStr('#fdf5f6')),
        child: Row(
        children: <Widget>[
          Container(
            width: (deviceWidth10(context) * 4) - 1,
            child: autoTextSizeH('光點', TextStyle(color: Colors.black, fontWeight: FontWeight.bold), context),
          ),
          buildLineHeight(),
          Container(
            width: (deviceWidth10(context) * 3) - 1,
            child: autoTextSizeH('BOSS卡板', TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), context),
          ),
          buildLineHeight(),
          Container(
            width: (deviceWidth10(context) * 3),
            child: autoTextSizeH('上線卡板', TextStyle(color: Colors.brown, fontWeight: FontWeight.bold), context),
          ),
          
        ],
      )
      );
    }
    else {
      return Container();
    }
  }
  ///取得使用者信息
  getUserInfoData() async {
    var res = await UserDao.getUserInfoLocal();
    user = res;
  }
  ///初始化
  initParam() async {
    //進入時先disable頭按鈕
    isEnableHeadBtns = false;
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
    //自移之外
    if(!isEnableHeadBtns) {
      var res = await WrongPlaceDao.getQueryNoNode();
      return res;
    }
    else {
      //統計按鈕之外
      if (nowType != buttonType.statistic) {
        var res = await WrongPlaceDao.getQueryWrongPlaceDetail(page: wpPage);
        return res;
      }
      else {
         var res = await WrongPlaceDao.getQueryWrongPlaceList();
         return res;
      }
    }
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
            title: Text('將選取的資轉', style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消', style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
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
    List<String> sortArray = ["正常"];
    List<Widget> wList = [];
    if(isEnableHeadBtns) {
      switch (nowType) {
        case buttonType.wp1: 
          if (user.isTransFromWP1 == 1) {
            if (this.toTransformArray.length < 2) {
            sortArray = ["自移","正常"];
            }
            else {
              sortArray = ["正常"];
            }
          }
          break;
        case buttonType.wp2: 
          if (user.isTransFromWP2 == 1) {
            if (this.toTransformArray.length >= 2) {
              sortArray = ["正常"];
            }
            else {
              sortArray = ["停訊","正常"];
            }
          }
          break;
        case buttonType.wp3:
          if (user.isTransFromWP3 == 1) {
            if (this.toTransformArray.length >= 2) {
              sortArray = ["正常"];
            }
            else {
              sortArray = ["重啟授權","正常"];
            }
          }
          
          break;
        case buttonType.statistic:
          sortArray = ["正常"];
          break;
      }
    }
    else {
      switch(nowAppBarType) {
        case appBarBtnType.noplace:
          sortArray = ["正常","派修","問題(可異)"];
          break;
        case appBarBtnType.wp2:
        
          // break;
        case appBarBtnType.cm:

          break;
        case appBarBtnType.stb:

        break;
      }
    }
      
    for (var sortStr in sortArray) {
      wList.add(
        CupertinoActionSheetAction(
          onPressed: () {
            switch (sortStr) {
              case "派修":
                typeStr = "FIX";
                break;
              case "低HP":
                typeStr = "LOWHP";
                break;
              case "正常":
                typeStr = "GOOD";
                break;
              case "追蹤":
                typeStr = "TRACK";
                break;
              case "可異":
                typeStr = "VBAD";
                break;
              case "問題":
                typeStr = "PROBLEM";
                break;
              case "無下行(超時)" :
                typeStr = "NODS";
                break;
              case "離線":
                typeStr = "OFFLINE";
                break;
              case "其他":
                typeStr = "OTHER";
                break;
              case "測機(追蹤)":
                typeStr = "TRACK4";
                break;
              case "觀察(派修)":
                typeStr = "WATCH";
                break;
              case "完工":
                typeStr = "FINISH";
                break;
              case "可優":
                typeStr = "VBAD2";
                break;
              case "NG":
                typeStr = "NG";
                break;
              case "問題(可異)":
                typeStr = "PROBLEM";
                break;
              default:
                break;
            }
            Navigator.pop(context);
            _transformDialog(context, to: typeStr, sortStr: sortStr);
          },
          child: Text(sortStr, style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
        )
      );
    }
    return wList;
  }
  _transformDialog(BuildContext context, {to,sortStr}) {
    Future.delayed(const Duration(seconds: 1), () {
      if (sortStr == "自移" || sortStr == "停訊") {
        showDialog(
          context: context,
          builder: (context) {
            var dialog = _buildWPDialog(context, sortStr);
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
  ///無應對刷新api
  getRefreshData(custNo) async {
    var res = await WrongPlaceDao.getRefreshData(custNo: custNo);
    return res;
  }
  ///刷新function
  void _callRefreshAPI(String custNo, int currentCellTag) async{
    isLoading = true;
    Fluttertoast.showToast(msg: '正在刷新該筆資料中..');
    var res = await getRefreshData(custNo);
    if(res != null && res.result) {
      var returnData = res.data["BossNodePath"];
      var dic = pullLoadWidgetControl.dataList[currentCellTag];
      setState(() {
        dic.BossNodePath = returnData;
        isLoading = false;
      });
    }
    else {
      isLoading = false;
    }
  }
  ///自移，停訊dialog
  Widget _buildWPDialog(BuildContext context,wpType) {
    return Material(
      type: MaterialType.transparency,
      child: Card(
        child: WrongPlaceDialog(wpType),
      ),
    );
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
    if(isEnableHeadBtns) {
      //統計按鈕之外都call這
      if (nowType != buttonType.statistic) {
        var res = await getApiDataList();
        if (res != null && res.result) {
          List<DefaultTableCell> list = new List();
          if (res.data["Data"] != null && res.data["Data"] != []) {
            dataArray.addAll(res.data["Data"]);
            wp1Count = res.data["WP1"];
            wp2Count = res.data["WP2"];
            wp3Count = res.data["WP3"];
          }
          if (dataArray.length > 0 ) {
            for (var dic in dataArray) {
              list.add(DefaultTableCell.fromJson(dic));
            }
          }
          
          setState(() {
            toTransformArray.clear();
            pullLoadWidgetControl.dataList.clear();
            clearData();

            pullLoadWidgetControl.dataList.addAll(list);
            pullLoadWidgetControl.needLoadMore = false;
          });
        }
      }
      else{
        //統計按鈕call這
        var res = await getApiDataList();
        if (res != null && res.result) {
          List<WrongPlaceNodeTableCell> list = new List();
          dataArray.addAll(res.data["Data"]);
          if (dataArray.length > 0 ) {
            for (var dic in dataArray) {
              list.add(WrongPlaceNodeTableCell.fromJson(dic));
            }
          }
          setState(() {
            toTransformArray.clear();
            pullLoadWidgetControl.dataList.clear();
            pullLoadWidgetControl.dataList.addAll(list);
            pullLoadWidgetControl.needLoadMore = false;
          });
        }
      }
    }
    else {
      //統計按鈕之外都call這
      var res = await getApiDataList();
      if (res != null && res.result) {
        List<WrongPlaceTableCell> list = new List();
        dataArray.addAll(res.data["Data"]);
        if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(WrongPlaceTableCell.fromJson(dic));
          }
        }
        setState(() {
          toTransformArray.clear();
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
  void initState() {
    super.initState();
    initParam();
  }

  @override
  void didChangeDependencies() {
    if(isEnableHeadBtns) {
      var list = _getStore().state.defaultList;
      pullLoadWidgetControl.dataList = list;
      if (pullLoadWidgetControl.dataList.length == 0) {
        setState(() {});
        showRefreshLoading();
      }
    }
    else {
      var list = _getStore().state.wrongPlaceList;
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
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
            body: Column(
              children: <Widget>[
                _renderHeader(),
                buildLine(),
                _statisticHead(),
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
  wp1,
  wp2,
  wp3,
  statistic,
}

enum appBarBtnType {
  noplace,
  wp2,
  cm,
  stb
}