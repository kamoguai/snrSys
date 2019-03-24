import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snr/common/localization/DefaultLocalizations.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyTabBarWidget.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyFlexButton.dart';
import 'package:snr/common/dao/HomeDao.dart';
import 'package:snr/common/model/HomeCmtsTitleInfo.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:snr/common/model/HomeSignal.dart';

/**
 * 主頁
 * Date: 2018-03-14
 */
class HomePage extends StatefulWidget {
  static final String sName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

var _major = "0";

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  CmtsTitleInfo ctInfo;
  List<SignalData> sdList;

  ///取得cmts表資料
  _cmtsTitleData() async {
    var res = await HomeDao.getQueryCMTSMainTitleInfoAPI();
    if (res != null && res.result) {
      setState(() {
        ctInfo = res.data;
      });
    }
    ;
  }

  ///取得signal資料
  _signalData() async {
    var res = await HomeDao.getQueryAllSNRSignalAPI();
    if (res != null && res.result) {
      setState(() {
        sdList = res.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _cmtsTitleData();
    _signalData();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  _fontSize() {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = 10.0;
    } else {
      fontSize = 16.0;
    }
    return fontSize;
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

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  _buildTextFontColor(String text, Color color) {
    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: MyConstant.minTextSize),
      minFontSize: 9.0,
    );
  }

  /// cmts talbe
  _buildCmtsTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      // defaultColumnWidth: IntrinsicColumnWidth(),
      columnWidths: const <int, TableColumnWidth>{
        // 0: FractionColumnWidth(1),
        1: FractionColumnWidth(.2),
        2: FractionColumnWidth(.2),
        3: FractionColumnWidth(.2),
      },
      border: TableBorder.all(
          color: Colors.grey, width: 1.0, style: BorderStyle.solid),
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_lhp
                  : CommonUtils.getLocale(context).home_cmtsTitle_lhp +
                      ': ${ctInfo.LHP}',
              style: TextStyle(fontSize: _fontSize()),
              minFontSize: 8.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_dowP
                  : CommonUtils.getLocale(context).home_cmtsTitle_dowP + ': ',
              style: TextStyle(fontSize: _fontSize(), color: Colors.purple),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_cut
                  : CommonUtils.getLocale(context).home_cmtsTitle_cut + ': ',
              style: TextStyle(fontSize: _fontSize()),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_major
                  : CommonUtils.getLocale(context).home_cmtsTitle_major +
                      ': ${ctInfo.MAJOR}',
              style: TextStyle(fontSize: _fontSize(), color: Colors.red),
              minFontSize: 1.0,
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_hp
                  : CommonUtils.getLocale(context).home_cmtsTitle_hp +
                      ': ${ctInfo.HP}',
              style: TextStyle(fontSize: _fontSize(), color: Colors.orange),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_watch
                  : CommonUtils.getLocale(context).home_cmtsTitle_watch + ': ',
              style: TextStyle(fontSize: _fontSize(), color: Colors.blue),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_fix2
                  : CommonUtils.getLocale(context).home_cmtsTitle_fix2 + ': ',
              style: TextStyle(fontSize: _fontSize(), color: Colors.pink),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_fix
                  : CommonUtils.getLocale(context).home_cmtsTitle_fix +
                      ': ${ctInfo.FIX}',
              style: TextStyle(fontSize: _fontSize(), color: Colors.red),
              minFontSize: 1.0,
            ),
          ],
        ),
      ],
    );
  }

  ///signal table
  _buildSignalTable() {
    return Container(
      padding: EdgeInsets.all(10.0),
      // height: 140.0,
      // color: Colors.yellow,
      child: DataTable(
          columns: <DataColumn>[
            DataColumn(
                label: Text(
                  CommonUtils.getLocale(context).home_signal_area,
                  style: TextStyle(
                      color: Colors.black, fontSize: MyConstant.minTextSize),
                ),
                // label: Text('', style: TextStyle(color: Colors.black),),
                numeric: false,
                tooltip: 'To display '),
            DataColumn(
                label: Text(
                  CommonUtils.getLocale(context).home_signal_online,
                  style: TextStyle(
                      color: Colors.blue, fontSize: MyConstant.minTextSize),
                ),
                // label: Text('', style: TextStyle(color: Colors.black),),
                numeric: false,
                tooltip: 'To display '),
            DataColumn(
                label: Text(
                  CommonUtils.getLocale(context).home_sinal_bad,
                  style: TextStyle(
                      color: Colors.red, fontSize: MyConstant.minTextSize),
                ),
                // label: Text('', style: TextStyle(color: Colors.black),),
                numeric: false,
                tooltip: 'To display '),
            DataColumn(
                label: Text(
                  CommonUtils.getLocale(context).home_signal_upP,
                  style: TextStyle(
                      color: Colors.black, fontSize: MyConstant.minTextSize),
                ),
                // label: Text('', style: TextStyle(color: Colors.black),),
                numeric: false,
                tooltip: 'To display '),
            DataColumn(
                label: Text(
                  CommonUtils.getLocale(context).home_signal_problem,
                  style: TextStyle(
                      color: Colors.pink, fontSize: MyConstant.minTextSize),
                ),
                // label: Text('', style: TextStyle(color: Colors.black),),
                numeric: false,
                tooltip: 'To display '),
            DataColumn(
                label: Text(
                  CommonUtils.getLocale(context).home_signal_percent,
                  style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: MyConstant.minTextSize),
                ),
                // label: Text('', style: TextStyle(color: Colors.black),),
                numeric: false,
                tooltip: 'To display '),
          ],
          rows: sdList == null
              ? []
              : sdList
                  .map((dic) => DataRow(cells: [
                         DataCell(Text(dic.Name),
                            showEditIcon: false, placeholder: false),
                        DataCell(Text(dic.OnLine),
                            showEditIcon: false, placeholder: false),
                        DataCell(Text(dic.Bad),
                            showEditIcon: false, placeholder: false),
                        DataCell(Text(dic.OverPower),
                            showEditIcon: false, placeholder: false),
                        DataCell(Text(dic.Problem),
                            showEditIcon: false, placeholder: false),
                        DataCell(Text(dic.BadRate.toString()),
                            showEditIcon: false, placeholder: false),
                      ]))
                  .toList()),
    );
  }

  _buildListView() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return new Container(
              height: 40.0,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: sdList == null
                        ? []
                        : <Widget>[
                            _buildTextFontColor(
                                sdList[index].Name, Colors.black),
                            _buildTextFontColor(
                                sdList[index].OnLine, Colors.blue),
                            _buildTextFontColor(sdList[index].Bad, Colors.red),
                            _buildTextFontColor(
                                sdList[index].OverPower, Colors.black),
                            _buildTextFontColor(
                                sdList[index].Problem, Colors.pink),
                            _buildTextFontColor(
                                sdList[index].BadRate.toString(),
                                Colors.blue[300]),
                          ],
                  ),
                  _buildLine()
                ],
              ));
        },
        itemCount: sdList.length,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ///通過state判斷app前後台切換
    if (state == AppLifecycleState.resumed) {
      print('resumed');
    } else if (state == AppLifecycleState.inactive) {
      print('inactive');
    } else if (state == AppLifecycleState.paused) {
      print('paused');
    } else if (state == AppLifecycleState.suspending) {
      print('suspending');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = 12.0;
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

    return WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: SafeArea(
          top: true,
          bottom: true,
          child: new Scaffold(
            ///appBar
            appBar: new AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              actions: <Widget>[
                new Expanded(
                  child: new Row(
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
                            _signalData();
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
                )
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
                          fontSize: MyConstant.smallTextSize,
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
                          fontSize: MyConstant.smallTextSize,
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
                          text: CommonUtils.getLocale(context)
                              .home_btn_publicwork,
                          color: Color(MyColors.hexFromStr("#e8fcff")),
                          fontSize: MyConstant.smallTextSize,
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
                          fontSize: MyConstant.smallTextSize,
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
                          text:
                              CommonUtils.getLocale(context).home_btn_assignFix,
                          color: Color(MyColors.hexFromStr("#fee6f7")),
                          fontSize: MyConstant.smallTextSize,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  new Card(color: Colors.white, child: _buildCmtsTable()),
                  _buildLine(),

                  /// 高度1的分隔線
                  new Container(
                    height: 40.0,
                    color: Color(MyColors.hexFromStr('#f5ffe9')),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildTextFontColor(
                            CommonUtils.getLocale(context).home_signal_area,
                            Colors.black),
                        _buildTextFontColor(
                            CommonUtils.getLocale(context).home_signal_online,
                            Colors.blue),
                        _buildTextFontColor(
                            CommonUtils.getLocale(context).home_sinal_bad,
                            Colors.red),
                        _buildTextFontColor(
                            CommonUtils.getLocale(context).home_signal_upP,
                            Colors.black),
                        _buildTextFontColor(
                            CommonUtils.getLocale(context).home_signal_problem,
                            Colors.pink),
                        _buildTextFontColor(
                            CommonUtils.getLocale(context).home_signal_percent,
                            Colors.blue[300]),
                      ],
                    ),
                  ),

                  /// 高度1的分隔線
                  _buildLine(),
                  // _buildSignalTable(),
                  _buildListView(),
                ],
              ),
            ),

            ///toolBar
            bottomNavigationBar: new Material(
              color: Theme.of(context).primaryColor,
              child: new Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 60.0,
                    child: new MyToolButton(
                      // padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                      // padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                    child: new FlatButton.icon(
                      icon: Image.asset(MyICons.DEFAULT_USER_ICON, width: 30, height: 30,),
                      textColor: Colors.white,
                      color: Colors.transparent,
                      label: Text('PING', style: TextStyle(fontSize: 10),),
                      onPressed: (){
                        print(123);
                      },
                    )
                    
                    // new MyToolButton(
                    //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  
                    //   text: "PING",
                    //   textColor: Colors.white,
                    //   color: Colors.transparent,
                    //   fontSize: fontSize,
                    //   onPress: () {
                    //     print("123");
                    //   },
                    // ),
                  ),
                  ButtonTheme(
                    minWidth: 60.0,
                    child: new MyToolButton(
                      // padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                      // padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
        )

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
