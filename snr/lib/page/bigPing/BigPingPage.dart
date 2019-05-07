
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/page/bigPing/BigPingTableItem.dart';
import 'package:snr/widget/MyToolBarButton.dart';
/**
 * 大PING頁面
 * Date: 2019-05-07
 */
class BigPingPage extends StatefulWidget {
  @override
  _BigPingPageState createState() => _BigPingPageState();
}

class _BigPingPageState extends State<BigPingPage> {
  var config;
  Map<String,dynamic> dataArray = Map<String,dynamic>();
  var textFiledStr = "";
  var isLoading = false;
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
      height: listHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切2份
  deviceWidth2(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 2;
  }

  ///取得裝置width並切3份
  deviceWidth3(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 3;
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
  _autoTextSize(text, style, BuildContext context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
    ///自動字大小s
  _autoTextSize_s(text, style, BuildContext context) {
    var fontSize = MyScreen.defaultTableCellFontSize_s(context);
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
      child: child,
    );
  }
  ///上面4個按鈕
  _fourBtnAction(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0,),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: deviceWidth4(context),
            child: MyToolButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),side: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)),
              textColor: Colors.black,
              color: Color(MyColors.hexFromStr('#ffeef1')),
              fontSize: MyScreen.appBarFontSize(context),
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
              fontSize: MyScreen.appBarFontSize(context),
              text: 'CPE',
              onPress: (){

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
              fontSize: MyScreen.appBarFontSize(context),
              text: 'FLAP',
              onPress: (){

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
              fontSize: MyScreen.appBarFontSize(context),
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
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
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
                padding: EdgeInsets.all(8.0),
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
    if(dataArray.length > 0) {
      model = BigPingViewModel.forMap(dataArray);
    }
    else {
      model = BigPingViewModel.forDummy(null);
    }
     
    return BigPingTableItem(model);
    
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
              print('it click');
              Navigator.pop(context);          
            },
          ),
        ),
      ],
    );
  }
  ///body
  _renderBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _fourBtnAction(context),
        _custNoPing(context),
        buildLine(),
        _pingView(),
      ],
    );
  }
  ///小ping function
  void _callPing(String custCode) async{
    if (isLoading) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
      return;
    }
    isLoading = true;
    Fluttertoast.showToast(msg: '正在ping該筆資料中..');
    var res = await getPingData(custCode);
    if(res != null && res.result) {
      setState(() {
        dataArray = res.data;
        _pingView();
        isLoading = false;
      });
    }
  }
  ///呼叫小ping api
  getPingData(custCode) async {
    var res = await DefaultTableDao.getPingSNR(_getStore(),context, custCode: custCode);
    return res;
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