
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/BigPingDao.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/BigPingTableItem.dart';

import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/dialog/CPEDialog.dart';
import 'package:snr/widget/dialog/FLAPDialog.dart';
import 'package:snr/widget/BaseWidget.dart';
/**
 * 大PING頁面
 * Date: 2019-05-07
 */
class BigPingPage extends StatefulWidget {
  final String custNo;
  BigPingPage({this.custNo});
  @override
  _BigPingPageState createState() => _BigPingPageState();
}

class _BigPingPageState extends State<BigPingPage> with BaseWidget {
  ///取得設定檔
  var config;
  ///裝ping data
  Map<String,dynamic> dataArray = Map<String,dynamic>();
  ///裝CPE data
  Map<String,dynamic> cpeArray = Map<String,dynamic>();
  ///裝FLAP data
  Map<String,dynamic> flapArray = Map<String,dynamic>();
  ///輸入框
  var textFiledStr = "";
  ///是否讀取中
  var isLoading = false;
  ///保留客編
  var custNoStr = "";
  ///保留客戶名
  var custNameStr = "";
  ///保留cmts
  var cmtsStr = "";
  ///保留cmmac
  var cmmacStr = "";

  ///上面4個按鈕
  _fourBtnAction(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: deviceWidth4(context),
            child: MyToolButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),side: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
              textColor: Colors.black,
              color: Color(MyColors.hexFromStr('#ffeef1')),
              fontSize: MyScreen.normalListPageFontSize(context),
              text: 'CW',
              onPress: () {
                
              },
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: deviceWidth4(context),
            child: MyToolButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),side: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
              textColor: Colors.black,
              color: Color(MyColors.hexFromStr('#f1ffff')),
              fontSize: MyScreen.normalListPageFontSize(context),
              text: 'CPE',
              onPress: () async{
                if(dataArray.length < 1) {
                  Fluttertoast.showToast(msg: '請先PING資料！');
                  return;
                }
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                if(cmtsStr == '---') {
                  Fluttertoast.showToast(msg: '查無資料!');
                  return;
                }
                Fluttertoast.showToast(msg: '正在獲取資料中...');
                var resData = await getCPEData();
                Future.delayed(const Duration(seconds: 1),() {
                  isLoading = false;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => cpeDialog(context, resData)
                  );
                });
              },
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: deviceWidth4(context),
            child: MyToolButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),side: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
              textColor: Colors.black,
              color: Color(MyColors.hexFromStr('#f5ffe9')),
              fontSize: MyScreen.normalListPageFontSize_s(context),
              text: 'FLAP',
              onPress: () async {
                if(dataArray.length < 1) {
                  Fluttertoast.showToast(msg: '請先PING資料！');
                  return;
                }
                if (isLoading) {
                  Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                  return;
                }
                if(cmtsStr == '---') {
                  Fluttertoast.showToast(msg: '查無資料!');
                  return;
                }
                Fluttertoast.showToast(msg: '正在獲取資料中...');
                var resData = await getFLAPData();
                Future.delayed(const Duration(seconds: 1),() {
                  isLoading = false;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => flapDialog(context, resData)
                  );
                });
              },
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: deviceWidth4(context),
            child: MyToolButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),side: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
              textColor: Colors.black,
              color: Color(MyColors.hexFromStr('#fffae4')),
              fontSize: MyScreen.normalListPageFontSize(context),
              text: '訊號',
              onPress: (){

              },
            )
          ),
        ],
      ),
    );
  }
  ///ping 客編相關
  _custNoPing(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    double paddingValue = 8.0;
    if (deviceHeight < 600) {
      paddingValue = 5.0;
    }
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text('客編', style: TextStyle(color: Colors.blue, fontSize: MyScreen.appBarFontSize(context))),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
              child: CupertinoTextField(
                style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.black),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: widget.custNo == null ? textFiledStr : widget.custNo),
                padding: EdgeInsets.all(paddingValue),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
                onChanged: (String value) {
                  textFiledStr = value;
                },
              ),
            ),
          ),    
          GestureDetector(
            child: Container(
              width: deviceWidth5(context),
              decoration: BoxDecoration(color: Color(MyColors.hexFromStr('#588fd3')),borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
              height: 30,
              child: Image.asset('static/images/23.png')
            ),
            onTap: (){
              if (widget.custNo != null) {
                textFiledStr = widget.custNo;
              }
              if(textFiledStr == "") {
                Fluttertoast.showToast(msg: '請輸入客編');
                return;
              }
              _callPing(textFiledStr);
            }, 
          )  
        ],
      ),
    );
  }
  ///讀取snr config
  _localConfig() async {
    final configData = await LocalStorage.get(Config.SNR_CONFIG);
    final dic = json.decode(configData);
    config = dic;
  }
  ///pingview
  _pingView() {
    BigPingViewModel model;
    model = BigPingViewModel.forMap(dataArray);
    return BigPingTableItem(defaultViewModel: model, configData: config,);
  }
  ///pingDummyview
  _pingDummyView() {
    BigPingViewModel model;
    model = BigPingViewModel.forDummy(null);
    return BigPingTableItem(defaultViewModel: model, configData: config,);
  }
  
  ///app bar actions
  _renderAppBarAction(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: deviceWidth3(context),
            child: Text('大PING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: MyScreen.appBarFontSize(context)),),
          ),
          Container(
            alignment: Alignment.center,
            width: deviceWidth3(context),
            child: FlatButton.icon(
              icon: Image.asset(
                MyICons.DEFAULT_USER_ICON,
                width: 30,
                height: 30,
              ),
              textColor: Colors.white,
              color: Colors.transparent,
              label: Text(
                'DCTV',
                style: TextStyle(
                    fontSize: MyScreen.normalPageFontSize_s(context)),
              ),
              onPressed: () {
                print(123);
              },
            )
          ),
          Container(
            width: deviceWidth3(context),
            child: MyToolButton(
              text: '',
              textColor: Colors.white,
              fontSize: MyScreen.appBarFontSize(context),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              onPress: (){
              
              },
            ),
          ),
        ],
      ),
    );
  }
  ///bottomNavBar item
  _renderBottomItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: CommonUtils.getLocale(context).common_toolBar_set,
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
            text: CommonUtils.getLocale(context).text_standar,
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
              Navigator.pop(context);          
            },
          ),
        ),
      ],
    );
  }
  ///body
  _renderBody(BuildContext context) {
    if(dataArray.length > 0 ){
      return Column(
        children: <Widget>[
          _fourBtnAction(context),
          _custNoPing(context),
          buildLine(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                _pingView(),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Column(
        children: <Widget>[
          _fourBtnAction(context),
          _custNoPing(context),
          buildLine(),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                _pingDummyView(),
              ],
            ),
          ),
        ],
      );
    }
  }
  ///小ping function
  void _callPing(String custCode) async{
    if (isLoading) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
      return;
    }
    // if(custCode.length < 10) {
    //   Fluttertoast.showToast(msg: '請輸入正確客編格式');
    //   return;
    // }
    FocusScope.of(context).requestFocus(FocusNode());
    isLoading = true;
    showLoadingDialog(context);
    var res = await getPingData(custCode);
    if(res != null && res.result) {
      hidenLoadingDialog(context);
      setState(() {
        dataArray = res.data;
        cmtsStr = dataArray["CMTS"];
        cmmacStr = dataArray["CMMAC"];
        custNameStr = dataArray["CustName"];
        custNoStr = dataArray["CustCode"];
        isLoading = false;
      });
    }
    else {
      Future.delayed(const Duration(seconds: 1),(){
        hidenLoadingDialog(context);
        isLoading = false;     
      });
    }
  }
  ///呼叫小ping api
  getPingData(custCode) async {
    var res = await DefaultTableDao.getPingSNR(_getStore(),context, custCode: custCode);
    return res;
  }
  ///呼叫cep api
  getCPEData() async {
    isLoading = true;
    var res = await BigPingDao.getCPEData(cmts: cmtsStr, cmmac: cmmacStr);
    return res;
  }
  ///呼叫flap api
  getFLAPData() async {
    isLoading = true;
    var res = await BigPingDao.getFLAPData(cmts: cmtsStr, cmmac: cmmacStr);
    return res;
  }
  ///清除flap api
  clearFlapData() async {
    isLoading = true;
    var res = await BigPingDao.clearFLAPData(cmts: cmtsStr, cmmac: cmmacStr);
    return res;
  }
  ///清除flap function
  void _clearFlapFunc() async {
    if (isLoading) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
      return;
    }
    var res = await clearFlapData();
    if(res != null && res.result) {
      isLoading = false;
      Fluttertoast.showToast(msg: res.data["MSG"]);
    }
    else {
      isLoading = false;
    }

  }
  ///cpe dialog
  Widget cpeDialog(BuildContext context, data) {
    return Material(
       type: MaterialType.transparency,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           Card(
             child: CPEDialog(custNoStr, custNameStr, data.data),
           )
         ],
       ),
    );
  }
  ///cpe dialog
  Widget flapDialog(BuildContext context, data) {
    FlapViewModel model;
    model = FlapViewModel.forMap(data.data);
    return Material(
       type: MaterialType.transparency,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           Card(
             child: FLAPDialog(custNo: custNoStr, custName: custNameStr, data: data.data, defaultViewModel: model, clearFlapFunc: _clearFlapFunc,),
           )
         ],
       ),
    );
  }
  
  @override
  void initState() {
    super.initState();
    _localConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Store<SysState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: Container(),
          elevation: 0.0,
          actions: <Widget>[
            _renderAppBarAction(context)
          ],
        ),
        body: _renderBody(context),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: _renderBottomItem(context)
        ),
      ),
    );
  }
}