
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';

class JumpSettingPage extends StatefulWidget {
  @override
  _JumpSettingPageState createState() => _JumpSettingPageState();
}

class _JumpSettingPageState extends State<JumpSettingPage> {

  ///數據資料arr
  final List<dynamic> dataArray = [];
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
    var fontSize = MyScreen.normalPageFontSize_s(context);
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
  ///初始化資料
  initParam() {

  }
  ///取得API資料
  getApiDataList() async {
    
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
  ///list item
  Widget _cmtsItme(BuildContext context, int index){

    return _container(
      color: Color(MyColors.hexFromStr('#f2fcff')),
      height: listHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: autoTextSize('CMTS', TextStyle(color: Colors.black), context),
          ),
          Container(
            child: autoTextSize(CommonUtils.getLocale(context).abnormal_card_text, TextStyle(color: Colors.black), context),
          ),
          Container(
            child: autoTextSize('跳頻時間', TextStyle(color: Colors.black), context),
          ),
          Container(
            child: autoTextSize('跳回', TextStyle(color: Colors.black), context),
          ),
          Container(
            child: autoTextSize('啟動人', TextStyle(color: Colors.black), context),
          )
        ],
      ),
    );
  }
  /// list view
  Widget _cmtsListView() {
    Widget listView;
    listView = Expanded(
      child: ListView.builder(
        itemBuilder: _cmtsItme,
        itemCount: dataArray.length + 2,
      ),
    );
    return listView;
  }
  ///自動跳頻container
  Widget _autoJumpView() {
    return _container(
      color: Color(MyColors.hexFromStr('#f4f9e9')),
      height: listHeight(context) * 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth6(context),
            child: autoTextSize('自動跳頻', TextStyle(color: Colors.black), context),
          ),
          Container(
            width: deviceWidth6(context),
            child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)), contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
          ),
          Container(
            width: deviceWidth6(context),
            child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)), contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
          ),
          Container(
            width: deviceWidth6(context),
            child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)), contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
          ),
          Container(
            width: deviceWidth6(context),
            child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)), contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
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
                
              },
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _container(
          height: deviceHeight4(context),
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
                      child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)), contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
                    ),
                    Container(
                      // width: deviceWidth4(context),
                      child: Text('卡板', style: TextStyle(color: Colors.black)),
                    ),
                    Container(
                      width: deviceWidth4(context),
                      child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
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
                      width: 60,
                      child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),contentPadding: EdgeInsets.all(5.0)),onChanged: (String value){print(value);},),
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
                    
                  },
                ),
              ),
            ],
          ),
        ),
        _container(
          height: listHeight(context),
          color: Color(MyColors.hexFromStr('#fbfcf9')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: autoTextSize('CMTS', TextStyle(color: Colors.black), context),
              ),
              Container(
                child: autoTextSize(CommonUtils.getLocale(context).abnormal_card_text, TextStyle(color: Colors.black), context),
              ),
              Container(
                child: autoTextSize('跳頻時間', TextStyle(color: Colors.black), context),
              ),
              Container(
                child: autoTextSize('跳回', TextStyle(color: Colors.black), context),
              ),
              Container(
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