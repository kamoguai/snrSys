
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/SettingDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/SsoLogin.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';

class JumpSettingPage extends StatefulWidget {
  JumpSettingPage({Key key}) : super(key: key);
  @override
  _JumpSettingPageState createState() => _JumpSettingPageState();
}

class _JumpSettingPageState extends State<JumpSettingPage> with AutomaticKeepAliveClientMixin<JumpSettingPage> {

  ///數據資料arr
  List<dynamic> logArray = new List<dynamic>();
  List<dynamic> cmtsArray = new List<dynamic>();
  List<dynamic> cifArray = new List<dynamic>();
  List<dynamic> delayTimeArray = new List<dynamic>();
  Map<String,dynamic> autoTimeMap = Map<String,dynamic>();
  var cType = "";
  var cmtsStr = "";
  var cmtsCode = "";
  var cifStr = "";
  var minsStr = "";
  var minsValue = "";
  var timeStr = "00";
  var timeTag = 0;
  var _time1 = "";
  var _time2 = "";
  var _time3 = "";
  var _time4 = "";
  var isLoading = false;
  var nowType = timeBtnType.time1;
  /// user model
  User user;
  /// sso model
  Sso sso;
  ///分隔線
  buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///分隔線red
  buildLineRed() {
    return new Container(
      height: 1.0,
      color: Colors.red,
    );
  }

  ///高分隔線
  buildLineHeight(context) {
    return new Container(
      height: titleHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切4份
  deviceWidth4(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 4;
  }

  ///取得裝置width並切5份
  deviceWidth5(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 5;
  }

  ///取得裝置width並切6份
  deviceWidth6(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }

  ///取得裝置height切4分
  deviceHeight4(context) {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  listHeight(context) {
    var height = deviceHeight4(context);
    return height / 5;
  }

  ///title height
  titleHeight(context) {
    var height = deviceHeight4(context);
    return height / 4;
  }

  ///自動字大小
  autoTextSize(text, style, BuildContext context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  ///container
  _container({child, height, width, color}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration( color: color,border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
      width: width,
      height: height,
      child: child,
    );
  }
  ///取得使用者信息
  getUserInfoData() async {
    var res = await UserDao.getUserInfoLocal();
    user = res;
  }
  ///初始化資料
  initParam() async {
    logArray = [];
    cmtsArray = [];
    cifArray = [];
    delayTimeArray = [];
    autoTimeMap = {};
    isLoading = true;
    var userRes = await UserDao.getUserInfoLocal();
    var ssoRes = await UserDao.getUserSSOInfoLocal();
    user = userRes.data;
    sso = ssoRes.data;
    user.accNo = await LocalStorage.get(Config.USER_NAME_KEY);
    user.accName = sso.accName;
    getApiDataList();
  }
  ///取得API資料
  getApiDataList() async {
    var autoTimeRes = await SettingDao.getQueryAutoFrequenceTime();
    // var cifRes = await SettingDao.getQueryJumpFreqCIF(cType: cType);
    var cmtsRes = await SettingDao.getQueryJumpFreqCMTS();
    var logRes = await SettingDao.getQueryJumpFreqLOG();
    var delayTimeRes = await SettingDao.getQuerySwitchDelayTime();
    setState(() {
        if (autoTimeRes != null && autoTimeRes.result) {
          autoTimeMap = autoTimeRes.data["Data"];
          _time1 = autoTimeMap["TIME1"];
          _time2 = autoTimeMap["TIME2"];
          _time3 = autoTimeMap["TIME3"];
          _time4 = autoTimeMap["TIME4"];
        }
        // if (cifRes != null && cifRes.result) {

        // }
        if (cmtsRes != null && cmtsRes.result) {
          cmtsArray = cmtsRes.data["Data"];
        }
        if (logRes != null && logRes.result) {
          logArray = logRes.data["Data"];
          isLoading = false;
        }
        if (delayTimeRes != null && delayTimeRes.result) {
          delayTimeArray = delayTimeRes.data["Data"];
        }
    });
  }
  ///送出移頻指令
  postUploadSwitchFreq() async{
    if(cifStr == null || cifStr == "") {
      Fluttertoast.showToast(msg: '填入資訊不完整!');
      return;
    }
    var res = await SettingDao.postUploadSwitchFreq(cmts: cmtsCode, cif: cifStr, accName: user.accName, delay: minsValue);
    if(res != null && res.result) {
      Fluttertoast.showToast(msg: '執行成功');
      return;
    }
  }
  setAutoFrequenceTime() async {
    var res = await SettingDao.setAutoFrequenceTime(time1: _time1, time2: _time2, time3: _time3, time4: _time4, );
    if(res != null && res.result) {
      Fluttertoast.showToast(msg: '執行成功');
      return;
    }
  }
  @override
  void initState() {
    super.initState();
    initParam();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
    else {
      return;
    }
  }
  @override
  bool get wantKeepAlive => true;
  ///list item
  Widget _cmtsItme(BuildContext context, int index){
    var dic = logArray[index];
    var swdt = dic["SWDT"].toString().length > 11 ? dic["SWDT"].toString().substring(0,11) : dic["SWDT"];
    var bkDt = dic["BKDT"].toString().length > 5 ? dic["BKDT"].toString().substring(0,5) : dic["BKDT"];
    return _container(
      color: Color(MyColors.hexFromStr('#f2fcff')),
      height: listHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth5(context),
            child: autoTextSize(dic["CMTS"], TextStyle(color: Colors.black), context),
          ),
          Container(
            width: deviceWidth5(context),
            child: autoTextSize(dic["CIF"], TextStyle(color: Colors.black), context),
          ),
          Container(
            width: deviceWidth5(context),
            child: autoTextSize(swdt, TextStyle(color: Colors.black), context),
          ),
          Container(
            width: deviceWidth5(context),
            child: autoTextSize(bkDt, TextStyle(color: Colors.black), context),
          ),
          Container(
            width: deviceWidth5(context),
            child: autoTextSize(dic["ISSUENAME"], TextStyle(color: Colors.black), context),
          )
        ],
      ),
    );
  }
  /// list view
  Widget _cmtsListView() {
    Widget listView;
    if (logArray.length > 0) {
      listView = Expanded(
        child: ListView.builder(
          itemBuilder: _cmtsItme,
          itemCount: logArray.length,
        ),
      );
    }
    else {
      listView = Center(child: Text('查無資料'),);
    }
    
    return listView;
  }
  ///自動跳頻container
  Widget _autoJumpView() {
    return _container(
      color: Color(MyColors.hexFromStr('#f4f9e9')),
      // height: listHeight(context) * 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth6(context) * 0.7,
            child: autoTextSize('自動\n跳頻', TextStyle(color: Colors.black), context),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left:2.0, right: 2.0, top: 5.0, bottom: 5.0),
              width: deviceWidth6(context),
              decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(4.0), border: Border.all(width: 1.0,style: BorderStyle.solid,color: Colors.grey)),              
              child: autoTextSize(_time1 == "" ? "" : _time1, TextStyle(color: Colors.black), context),
            ),
            onTap: (){
              nowType = timeBtnType.time1;
              _selectTime(context, _time1);
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left:2.0, right: 2.0, top: 5.0, bottom: 5.0),
              width: deviceWidth6(context),
              decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(4.0), border: Border.all(width: 1.0,style: BorderStyle.solid,color: Colors.grey)),              
              child: autoTextSize(_time2 == "" ? "" : _time2, TextStyle(color: Colors.black), context),
            ),
            onTap: (){
              nowType = timeBtnType.time2;
              _selectTime(context, _time2);
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left:2.0, right: 2.0, top: 5.0, bottom: 5.0),
              width: deviceWidth6(context),
              decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(4.0), border: Border.all(width: 1.0,style: BorderStyle.solid,color: Colors.grey)),              
              child: autoTextSize(_time3 == "" ? "" : _time3, TextStyle(color: Colors.black), context),
            ),
            onTap: (){
              nowType = timeBtnType.time3;
              _selectTime(context, _time3);
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left:2.0, right: 2.0, top: 5.0, bottom: 5.0),
              width: deviceWidth6(context),
              decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(4.0), border: Border.all(width: 1.0,style: BorderStyle.solid,color: Colors.grey)),              
              child: autoTextSize(_time4 == "" ? "" : _time4, TextStyle(color: Colors.black), context),
            ),
            onTap: (){
              nowType = timeBtnType.time4;
              _selectTime(context, _time4);
            },
          ),
          Container(
            width: deviceWidth6(context),
            child: MyToolButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              text: '送出',
              textColor: Colors.white,
              color: Colors.orange,
              fontSize: MyScreen.homePageFontSize(context),
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              onPress: () {
                setAutoFrequenceTime();
              },
            ),
          )
        ],
      )
    );
  }
  ///dialog-cmts
  showCmtsDialog(BuildContext context) {
     List<Widget> wList = [];
     for (var dic in cmtsArray) {
       wList.add(CupertinoActionSheetAction(
         onPressed: () {
           setState(() {
             cType = dic["CType"];
             cmtsCode = dic["CMTSCode"];
             cmtsStr = dic["Name"];
           });
           Navigator.pop(context);
         },
         child: Text(dic["Name"]),
       ));
     }
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
            actions: wList,
          );
          return dialog;
        }
     );
  }
  ///dialog-cif
  showCifDialog(BuildContext context) async{
    if (cmtsCode == "") {
      Fluttertoast.showToast(msg: '請先選CMTS');
      return;
    }
    var res = await SettingDao.getQueryJumpFreqCIF(cType: cType);
    List<Widget> wList = [];
    if(res != null && res.result) {
      cifArray = res.data["Data"];
      for (var dic in cifArray) {
        wList.add(CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              cifStr = dic["Name"];
            });
            Navigator.pop(context);
          },
          child: Text(dic["Name"]),
        ));
      }
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
            actions: wList,
          );
          return dialog;
        }
      );
    }
    else {
      Fluttertoast.showToast(msg: '請先選CMTS');
      return;
    }
    
  }
  ///dialog-mins
  showMinsDialog(BuildContext context) {
     List<Widget> wList = [];
     for (var dic in delayTimeArray) {
       wList.add(CupertinoActionSheetAction(
         onPressed: () {
           setState(() {
             minsValue = dic["Value"];
             minsStr = dic["Code"];
           });
           Navigator.pop(context);
         },
         child: Text(dic["Code"]),
       ));
     }
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
            actions: wList,
          );
          return dialog;
        }
     );
  }
  ///使用flutter原本timePicker
  Future<Null> _selectTime(BuildContext context, timeStr) async {
    var splitStr = timeStr.split(":");
    var splitH = splitStr[0];
    var splitM = splitStr[1];
    final TimeOfDay _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: int.parse(splitH),minute: int.parse(splitM)),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      }
    );
    if(_picked != null ) {
      setState(() {
        switch (nowType) {
          case timeBtnType.time1:
            _time1 = _picked.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
            break;
          case timeBtnType.time2:
            _time2 = _picked.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
            break;
          case timeBtnType.time3:
            _time3 = _picked.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
            break;
          case timeBtnType.time4:
            _time4 = _picked.toString().replaceAll("TimeOfDay(", "").replaceAll(")", "");
            break;
        }
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _container(
          height: deviceHeight4(context) * 1.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      // width: deviceWidth4(context),
                      child: Text('CMTS', style: TextStyle(color: Colors.black)),
                    ),
                    Container(
                      width: deviceWidth4(context),
                      child: MyToolButton(
                        text: cmtsCode == "" ? "" : cmtsStr,
                        textColor: Colors.black,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalListPageFontSize_s(context),
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0), borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
                        onPress: () {
                          showCmtsDialog(context);
                        },
                      )
                    ),
                    Container(
                      // width: deviceWidth4(context),
                      child: Text('卡板', style: TextStyle(color: Colors.black)),
                    ),
                    Container(
                      width: deviceWidth4(context),
                      child: MyToolButton(
                        text: cifStr == "" ? "" : cifStr,
                        textColor: Colors.black,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalListPageFontSize_s(context),
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0), borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
                        onPress: () {
                          showCifDialog(context);
                        },
                      )
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15.0,),
                    Container(
                      child: Text('跳回原頻段時間', style: TextStyle(color: Colors.black)),
                    ),
                    Container(
                      width: deviceWidth4(context) * 0.7,
                      child: MyToolButton(
                        text: minsStr == "" ? "" : minsStr,
                        textColor: Colors.black,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalListPageFontSize_s(context),
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0), borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
                        onPress: () {
                          showMinsDialog(context);
                        },
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 3.0),
                      child: Text('分鐘。', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 5.0,),
              Container(
                width: deviceHeight4(context),
                child: MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: '送出',
                  textColor: Colors.black,
                  color: Color(MyColors.hexFromStr('#b0a3c4')),
                  fontSize: MyScreen.homePageFontSize(context),
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  onPress: () {
                    postUploadSwitchFreq();
                  },
                ),
              ),
            ],
          ),
        ),
        _container(
          height: listHeight(context),
          color: Color(MyColors.hexFromStr('#f4f9e9')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth5(context),
                child: autoTextSize('CMTS', TextStyle(color: Colors.black), context),
              ),
              Container(
                width: deviceWidth5(context),
                child: autoTextSize(CommonUtils.getLocale(context).abnormal_card_text, TextStyle(color: Colors.black), context),
              ),
              Container(
                width: deviceWidth5(context),
                child: autoTextSize('跳頻時間', TextStyle(color: Colors.black), context),
              ),
              Container(
                width: deviceWidth5(context),
                child: autoTextSize('跳回', TextStyle(color: Colors.black), context),
              ),
              Container(
                width: deviceWidth5(context),
                child: autoTextSize('啟動人', TextStyle(color: Colors.black), context),
              ),
            ],
          )
        ),
        _cmtsListView(),
        _autoJumpView(),
      ],
    );
  }

  
}
enum timeBtnType {
  time1,
  time2,
  time3,
  time4,
}