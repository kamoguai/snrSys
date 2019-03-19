import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snr/common/localization/DefaultLocalizations.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyTabBarWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyFlexButton.dart';

/**
 * 主頁
 * Date: 2018-03-14
 */
class HomePage extends StatelessWidget {
  static final String sName = "home";

  ///提示退出app
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text(CommonUtils.getLocale(context).app_back_tip),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text(CommonUtils.getLocale(context).app_cancel)),
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: new Text(CommonUtils.getLocale(context).app_ok))
              ],
            ));
  }

  /// tool bar
  _renderTab(text) {
    return new Tab(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[new Text(text)],
    ));
  }

  _renderIconTab(text) {
    return new Tab(
      child: new Row(
        children: <Widget>[
          Container(
            child: new Image(
              image: new AssetImage('static/images/logo_small.png'),
              width: 10.0,
              height: 10.0,
            ),
          ),
          new Text(text)
        ],
      ),
    );
  }

  _buildButtonItem(String title, var value, String color, onPressed) {
    return new Center(
      child: new RaisedButton(
        elevation: 2.0,
        highlightElevation: 8.0,
        disabledElevation: 0.0,
        clipBehavior: Clip.none,
        padding: EdgeInsets.only(top: 8.0),
        color: Color(MyColors.hexFromStr(color)),
        textColor: Colors.white,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = 10.0;
    } else {
      fontSize = 16.0;
    }
    List<Widget> tabs = [
      _renderTab(CommonUtils.getLocale(context).common_toolBar_refresh),
      _renderTab(CommonUtils.getLocale(context).common_toolBar_analyze),
      // _renderIconTab('PING'),
      _renderTab(CommonUtils.getLocale(context).common_toolBar_set),
      _renderTab(CommonUtils.getLocale(context).common_toolBar_back),
    ];
    _getListData() {
      List<Widget> widgets = [];
      for (int i = 0; i < 100; i++) {
        widgets
            .add(Padding(padding: EdgeInsets.all(10.0), child: Text("Row $i")));
      }
      return widgets;
    }

    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new Scaffold(
        ///appBar
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 60.0,
                  child: new MyToolButton(
                    text: "新北市",
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: fontSize,
                    onPress: () {
                      print("123");
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 60.0,
                  child: new MyToolButton(
                    text: "自移",
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: fontSize,
                    onPress: () {
                      print("123");
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 60.0,
                  child: new MyToolButton(
                    text: "點數",
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: fontSize,
                    onPress: () {
                      print("123");
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 60.0,
                  child: new MyToolButton(
                    text: "鎖HP",
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: fontSize,
                    mainAxisAlignment: MainAxisAlignment.start,
                    onPress: () {
                      print("123");
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 60.0,
                  child: new MyToolButton(
                    text: "資料",
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: fontSize,
                    mainAxisAlignment: MainAxisAlignment.start,
                    onPress: () {
                      print("123");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),

        ///body
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Row(
                ///裝button的row
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 60,
                    height: 35,
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey)),
                      text: CommonUtils.getLocale(context).home_btn_bigbad,
                      color: Color(MyColors.hexFromStr("#fee9fa")),
                      fontSize: fontSize,
                      textColor: Colors.black,
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 60,
                    height: 35,
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey)),
                      text: CommonUtils.getLocale(context).home_btn_upP,
                      color: Color(MyColors.hexFromStr("#f5ffe9")),
                      fontSize: fontSize,
                      textColor: Colors.black,
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 60,
                    height: 35,
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey)),
                      text: CommonUtils.getLocale(context).home_btn_publicwork,
                      color: Color(MyColors.hexFromStr("#e8fcff")),
                      fontSize: fontSize,
                      textColor: Colors.black,
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 60,
                    height: 35,
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey)),
                      text: CommonUtils.getLocale(context).home_btn_problem,
                      color: Color(MyColors.hexFromStr("#fff7dc")),
                      fontSize: fontSize,
                      textColor: Colors.black,
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 60,
                    height: 35,
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey)),
                      text: CommonUtils.getLocale(context).home_btn_assignFix,
                      color: Color(MyColors.hexFromStr("#fee6f7")),
                      fontSize: fontSize,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              new Card(
                  color: Colors.yellow,
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(100.0),
                      1: FixedColumnWidth(70.0),
                      2: FixedColumnWidth(70.0),
                      3: FixedColumnWidth(70.0),
                    },
                    border: TableBorder.all(
                        color: Colors.red,
                        width: 1.0,
                        style: BorderStyle.solid),
                    children: const <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Text('A1'),
                          Text('B1'),
                          Text('C1'),
                          Text('D1'),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Text('A2'),
                          Text('B2'),
                          Text('C2'),
                          Text('D2'),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Text('A3'),
                          Text('B3'),
                          Text('C3'),
                          Text('D3'),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),

        ///toolBar
        bottomNavigationBar: new Material(
          color: Theme.of(context).primaryColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: 60.0,
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: "刷新",
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: fontSize,
                  onPress: () {
                    print("123");
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 60.0,
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: "分析",
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: fontSize,
                  onPress: () {
                    print("123");
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 60.0,
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: "PING",
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: fontSize,
                  onPress: () {
                    print("123");
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 60.0,
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: "設定",
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: fontSize,
                  onPress: () {
                    print("123");
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 60.0,
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: "返回",
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: fontSize,
                  mainAxisAlignment: MainAxisAlignment.start,
                  onPress: () {
                    print("123");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      /*
      child: new MyTabBarWidget(
        type: MyTabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: <Widget>[

        ],
        backgroundColor: MyColors.primarySwatch,
        indicatorColor: Color(MyColors.white),
      ), 
      */
    );
  }
}
