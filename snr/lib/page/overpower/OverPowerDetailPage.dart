
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/dao/OverPowerDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/model/SsoLogin.dart';
import 'package:snr/widget/dialog/SmallPingTableItem.dart';

/**
 * >51詳情頁面
 * Date: 2019-04-23
 */
class OverPowerDetailPage extends StatefulWidget {
  @override
  _OverPowerDetailPageState createState() => _OverPowerDetailPageState();
}

class _OverPowerDetailPageState extends State<OverPowerDetailPage> with AutomaticKeepAliveClientMixin<OverPowerDetailPage>, MyListState<OverPowerDetailPage>, WidgetsBindingObserver {
  ///snr設定檔
  var config;
  ///現在按鈕enum
  var nowBtnType = buttonType.extra;
  var nowBtnType2 = buttonType2.four;
  ///hub
  var strHub = "";
  ///現在功能
  var typevalue = "OverPower";
  ///同上
  var typeof = "OverPower";
  ///外網
  var fEXT = 0.0;
  ///內網
  var fINT = 0.0;
  ///config snr顏色
  var netType = "EXT";
  /// 判斷是否外網
  var isExt = false;
  /// user model
  User user;
  /// sso model
  Sso sso;
  ///跳轉客編arr
  final List<String> toTransformArray = [];
  ///數據資料arr
  final List<dynamic> dataArray = [];
  final List<dynamic> firstArray = [];
  final List<dynamic> secondArray = [];
  final List<dynamic> originalArray = [];
  ///列表顯示的物件
  _renderItem(index) {
    DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
    DefaultViewModel model = DefaultViewModel.forMap(dtc);
    return new DefaultTableItem(defaultViewModel: model, configData: config, addTransform: _addTransform, addTransformArray: toTransformArray, callPing: _callPing, currentCellTag: index,netType: netType ,);
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
                  .text_extranet,
              color: Color(MyColors.hexFromStr("#eeffef")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType == buttonType.extra ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowBtnType = buttonType.extra;
                  nowBtnType2 = buttonType2.four;
                  _extraBtnEvent();
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
                  .text_intranet,
              color: Color(MyColors.hexFromStr("#fef5f6")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType == buttonType.intra ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowBtnType = buttonType.intra;
                  nowBtnType2 = buttonType2.four;
                  _intraBtnEvent();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.op4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: '4',
              color: Color(MyColors.hexFromStr("#f2f2f2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType2 == buttonType2.four ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowBtnType2 = buttonType2.four;
                  _fourBtnEvent();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.op4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: '3',
              color: Color(MyColors.hexFromStr("#f2f2f2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType2 == buttonType2.three ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowBtnType2 = buttonType2.three;
                  _threeBtnEvent();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.op4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: '2',
              color: Color(MyColors.hexFromStr("#f2f2f2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType2 == buttonType2.two ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowBtnType2 = buttonType2.two;
                  _twoBtnEvent();
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: MyScreen.op4BtnWidth(context),
            height: 35,
            child: new MyToolButton(
              padding:
                  EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: '1',
              color: Color(MyColors.hexFromStr("#f2f2f2")),
              fontSize: MyScreen.normalListPageFontSize(context),
              textColor: nowBtnType2 == buttonType2.one ? Colors.red : Colors.grey[700],
              onPress: () {
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                setState(() {
                  nowBtnType2 = buttonType2.one;
                  _oneBtnEvent();
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
    fEXT = double.parse(config["USDB_MAX_EXT"]);
    fINT = double.parse(config["USDB_MAX_INT"]);
    isExt = true;
  }
  ///get api data
  getApiDataList() async {
    var res = await OverPowerDao.getQueryList(_getStore(),
    city: strCity,
    sort: strSort,
    hub: strHub,
    type: typevalue
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
    List<String> sortArray = ["其他(可異)","派修","無下行(超時)"];
    List<Widget> wList = [];
      
      for (var sortStr in sortArray) {
        wList.add(
          CupertinoActionSheetAction(
            onPressed: () {
              switch (sortStr) {
                case "派修":
                  typeStr = "FIX";
                  break;
                case "可異":
                  typeStr = "VBAD";
                  break;
                case "正常":
                  typeStr = "GOOD";
                  break;
                case "其他(可異)":
                  typeStr = "OTHER";
                  break;
                case "觀察(派修)":
                  typeStr = "WATCH";
                  break;
                case "NG":
                  typeStr = "NG";
                  break;
                case "無下行(超時)":
                  typeStr = "NODS";
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
                  style: TextStyle(color: Colors.black, ),
                  children: <TextSpan>[TextSpan(text: '${sortStr}', style: TextStyle(color: Colors.blue, )),]
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
  ///外網按鈕event
  _extraBtnEvent() {
    dataArray.clear();
    secondArray.clear();
    firstArray.clear();
    isExt = true;
    var check = 0;
    List<DefaultTableCell> list = new List();
    for (var dic in originalArray) {
      if (dic["BB"] != null && dic["BB"] != "") {
        if (dic["BB"] == "內網") {
          secondArray.add(dic);
        }
      }
    }
    for (var dic in secondArray) {
      var u0P = dic["U0_PWR"];
      var u1P = dic["U1_PWR"];
      var u2P = dic["U2_PWR"];
      var u3P = dic["U3_PWR"];
      var intu0P = double.parse(u0P) ?? 0;
      var intu1P = double.parse(u1P) ?? 0;
      var intu2P = double.parse(u2P) ?? 0;
      var intu3P = double.parse(u3P) ?? 0;
      if (intu0P >= fEXT || u0P == "---") {
        check += 1;
      }
      if (intu1P >= fEXT || u1P == "---") {
        check += 1;
      }
      if (intu2P >= fEXT || u2P == "---") {
        check += 1;
      }
      if (intu3P >= fEXT || u3P == "---") {
        check += 1;
      }
      if (check == 4) {
        dataArray.add(dic);
      }
      check = 0;
    }
    firstArray.addAll(secondArray);
    if (dataArray.length > 0 ) {
      for (var dic in dataArray) {
        list.add(DefaultTableCell.fromJson(dic));
      }
    }
    ///將資料塞回dataList
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(list);
  }
  ///內網按鈕event
  _intraBtnEvent() {
    dataArray.clear();
    secondArray.clear();
    firstArray.clear();
    isExt = false;
    var check = 0;
    List<DefaultTableCell> list = new List();
    for (var dic in originalArray) {
      if (dic["BB"] != null && dic["BB"] != "") {
        if (dic["BB"] == "內網") {
          secondArray.add(dic);
        }
      }
    }
    for (var dic in secondArray) {
      var u0P = dic["U0_PWR"];
      var u1P = dic["U1_PWR"];
      var u2P = dic["U2_PWR"];
      var u3P = dic["U3_PWR"];
      var intu0P = double.parse(u0P) ?? 0;
      var intu1P = double.parse(u1P) ?? 0;
      var intu2P = double.parse(u2P) ?? 0;
      var intu3P = double.parse(u3P) ?? 0;
      if (intu0P >= fINT || u0P == "---") {
        check += 1;
      }
      if (intu1P >= fINT || u1P == "---") {
        check += 1;
      }
      if (intu2P >= fINT || u2P == "---") {
        check += 1;
      }
      if (intu3P >= fINT || u3P == "---") {
        check += 1;
      }
      if (check == 4) {
        dataArray.add(dic);
      }
      check = 0;
    }
    netType = "INT";
    firstArray.addAll(secondArray);
    if (dataArray.length > 0 ) {
      for (var dic in dataArray) {
        list.add(DefaultTableCell.fromJson(dic));
      }
    }
    ///將資料塞回dataList
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(list);
  }
  ///4按鈕event
  _fourBtnEvent() {
    secondArray.clear();
    dataArray.clear();
    var check = 0;
    var finalValue = 0.0;
    List<DefaultTableCell> list = new List();
    for (var dic in firstArray) {
      if (dic["BB"] != null && dic["BB"] != ""){
        if(dic["BB"] != "內網"){
          finalValue = fEXT;
        }
        else {
          finalValue = fINT;
        }
      } 
    }
    // var sortArr = firstArray.sort((a,b) {return a["BB"].toLowerCase().comoareTo(b["BB"].toLowerCase());});
    for (var dic in firstArray) {
      var u0P = dic["U0_PWR"];
      var u1P = dic["U1_PWR"];
      var u2P = dic["U2_PWR"];
      var u3P = dic["U3_PWR"];
      var intu0P = double.parse(u0P) ?? 0;
      var intu1P = double.parse(u1P) ?? 0;
      var intu2P = double.parse(u2P) ?? 0;
      var intu3P = double.parse(u3P) ?? 0;
      if (intu0P >= finalValue || u0P == "---") {
        check += 1;
      }
      if (intu1P >= finalValue || u1P == "---") {
        check += 1;
      }
      if (intu2P >= finalValue || u2P == "---") {
        check += 1;
      }
      if (intu3P >= finalValue || u3P == "---") {
        check += 1;
      }
      if (check == 4) {
        secondArray.add(dic);
      }
      check = 0;
    }
    dataArray.addAll(secondArray);
    if (dataArray.length > 0 ) {
      for (var dic in dataArray) {
        list.add(DefaultTableCell.fromJson(dic));
      }
    }
    ///將資料塞回dataList
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(list);
  }
  ///3按鈕event
  _threeBtnEvent() {
    secondArray.clear();
    dataArray.clear();
    var check = 0;
    var finalValue = 0.0;
    List<DefaultTableCell> list = new List();
    for (var dic in firstArray) {
      if (dic["BB"] != null && dic["BB"] != ""){
        if(dic["BB"] != "內網"){
          finalValue = fEXT;
        }
        else {
          finalValue = fINT;
        }
      } 
    }
    // var sortArr = firstArray.sort((a,b) {return a["BB"].toLowerCase().comoareTo(b["BB"].toLowerCase());});
    for (var dic in firstArray) {
      var u0P = dic["U0_PWR"];
      var u1P = dic["U1_PWR"];
      var u2P = dic["U2_PWR"];
      var u3P = dic["U3_PWR"];
      var intu0P = double.parse(u0P) ?? 0;
      var intu1P = double.parse(u1P) ?? 0;
      var intu2P = double.parse(u2P) ?? 0;
      var intu3P = double.parse(u3P) ?? 0;
      if (intu0P >= finalValue || u0P == "---") {
        check += 1;
      }
      if (intu1P >= finalValue || u1P == "---") {
        check += 1;
      }
      if (intu2P >= finalValue || u2P == "---") {
        check += 1;
      }
      if (intu3P >= finalValue || u3P == "---") {
        check += 1;
      }
      if (check == 3) {
        secondArray.add(dic);
      }
      check = 0;
    }
    dataArray.addAll(secondArray);
    if (dataArray.length > 0 ) {
      for (var dic in dataArray) {
        list.add(DefaultTableCell.fromJson(dic));
      }
    }
    ///將資料塞回dataList
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(list);
  }
  ///2按鈕event
  _twoBtnEvent() {
    secondArray.clear();
    dataArray.clear();
    var check = 0;
    var finalValue = 0.0;
    List<DefaultTableCell> list = new List();
    for (var dic in firstArray) {
      if (dic["BB"] != null && dic["BB"] != ""){
        if(dic["BB"] != "內網"){
          finalValue = fEXT;
        }
        else {
          finalValue = fINT;
        }
      } 
    }
    // var sortArr = firstArray.sort((a,b) {return a["BB"].toLowerCase().comoareTo(b["BB"].toLowerCase());});
    for (var dic in firstArray) {
      var u0P = dic["U0_PWR"];
      var u1P = dic["U1_PWR"];
      var u2P = dic["U2_PWR"];
      var u3P = dic["U3_PWR"];
      var intu0P = double.parse(u0P) ?? 0;
      var intu1P = double.parse(u1P) ?? 0;
      var intu2P = double.parse(u2P) ?? 0;
      var intu3P = double.parse(u3P) ?? 0;
      if (intu0P >= finalValue || u0P == "---") {
        check += 1;
      }
      if (intu1P >= finalValue || u1P == "---") {
        check += 1;
      }
      if (intu2P >= finalValue || u2P == "---") {
        check += 1;
      }
      if (intu3P >= finalValue || u3P == "---") {
        check += 1;
      }
      if (check == 2) {
        secondArray.add(dic);
      }
      check = 0;
    }
    dataArray.addAll(secondArray);
    if (dataArray.length > 0 ) {
      for (var dic in dataArray) {
        list.add(DefaultTableCell.fromJson(dic));
      }
    }
    ///將資料塞回dataList
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(list);
  }
  ///1按鈕event
  _oneBtnEvent() {
    secondArray.clear();
    dataArray.clear();
    var check = 0;
    var finalValue = 0.0;
    List<DefaultTableCell> list = new List();
    for (var dic in firstArray) {
      if (dic["BB"] != null && dic["BB"] != ""){
        if(dic["BB"] != "內網"){
          finalValue = fEXT;
        }
        else {
          finalValue = fINT;
        }
      } 
    }
    // var sortArr = firstArray.sort((a,b) {return a["BB"].toLowerCase().comoareTo(b["BB"].toLowerCase());});
    for (var dic in firstArray) {
      var u0P = dic["U0_PWR"];
      var u1P = dic["U1_PWR"];
      var u2P = dic["U2_PWR"];
      var u3P = dic["U3_PWR"];
      var intu0P = double.parse(u0P) ?? 0;
      var intu1P = double.parse(u1P) ?? 0;
      var intu2P = double.parse(u2P) ?? 0;
      var intu3P = double.parse(u3P) ?? 0;
      if (intu0P >= finalValue || u0P == "---") {
        check += 1;
      }
      if (intu1P >= finalValue || u1P == "---") {
        check += 1;
      }
      if (intu2P >= finalValue || u2P == "---") {
        check += 1;
      }
      if (intu3P >= finalValue || u3P == "---") {
        check += 1;
      }
      if (check == 1) {
        secondArray.add(dic);
      }
      check = 0;
    }
    dataArray.addAll(secondArray);
    if (dataArray.length > 0 ) {
      for (var dic in dataArray) {
        list.add(DefaultTableCell.fromJson(dic));
      }
    }
    ///將資料塞回dataList
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(list);
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
    firstArray.clear();
    secondArray.clear();
    originalArray.clear();
    if (isLoading) {
      return null;
    }
    isLoading = true;
 
    var res = await getApiDataList();
    if (res != null && res.result) {
      List<DefaultTableCell> list = new List();
      var mainData = res.data["Data"];
      var countData = res.data["Counts"];
      List<dynamic> inLineArr = [];
      originalArray.addAll(res.data["Data"]);
      for (var dic in originalArray) {
        if (dic["BB"] != null && dic["BB"] != "") {
          if (dic["BB"] != "內網") {
            firstArray.add(dic);
          }
          else {
            secondArray.add(dic);
          }
        }
      }
      var check = 0;
      firstArray.sort((a,b) => b["BB"].length.compareTo(a["BB"].length));
      for (var dic in firstArray) {
        var u0P = dic["U0_PWR"];
        var u1P = dic["U1_PWR"];
        var u2P = dic["U2_PWR"];
        var u3P = dic["U3_PWR"];
        var intu0P = double.parse(u0P) ?? 0;
        var intu1P = double.parse(u1P) ?? 0;
        var intu2P = double.parse(u2P) ?? 0;
        var intu3P = double.parse(u3P) ?? 0;
        if (intu0P >= fEXT || u0P == "---") {
          check += 1;
        }
        if (intu1P >= fEXT || u1P == "---") {
          check += 1;
        }
        if (intu2P >= fEXT || u2P == "---") {
          check += 1;
        }
        if (intu3P >= fEXT || u3P == "---") {
          check += 1;
        }
        if (check == 4) {
          dataArray.add(dic);
        }
        check = 0;
      }
      for (var dic in secondArray) {
        var u0P = dic["U0_PWR"];
        var u1P = dic["U1_PWR"];
        var u2P = dic["U2_PWR"];
        var u3P = dic["U3_PWR"];
        var intu0P = double.parse(u0P) ?? 0;
        var intu1P = double.parse(u1P) ?? 0;
        var intu2P = double.parse(u2P) ?? 0;
        var intu3P = double.parse(u3P) ?? 0;
        if (intu0P >= fINT || u0P == "---") {
          check += 1;
        }
        if (intu1P >= fINT || u1P == "---") {
          check += 1;
        }
        if (intu2P >= fINT || u2P == "---") {
          check += 1;
        }
        if (intu3P >= fINT || u3P == "---") {
          check += 1;
        }
        if (check == 4) {
          inLineArr.add(dic);
        }
        check = 0;
      }
      ///如果是內網就進入
      if (!isExt) {
        dataArray.clear();
        dataArray.addAll(inLineArr);
      }
      if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(DefaultTableCell.fromJson(dic));
          }
      }
      setState(() {
        toTransformArray.clear();
        pullLoadWidgetControl.dataList.clear();
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
                          text: CommonUtils.getLocale(context).text_overPowerBad,
                          textColor: Colors.yellow,
                          color: Colors.transparent,
                          fontSize: MyScreen.normalPageFontSize(context),
                          onPress: () {
                            
                          },
                        ),
                      ),
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
                    )
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
  extra,
  intra,
}
enum buttonType2 {
  one,
  two,
  three,
  four
}