import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/dao/HomeDao.dart';
import 'package:snr/common/model/HomeCmtsTitleInfo.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:snr/common/model/HomeSignal.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/common/dao/BigBadDao.dart';
import 'package:snr/common/model/BigBad.dart';


/**
 * 主頁
 * Date: 2018-03-14
 */
class HomePage extends StatefulWidget {
  static final String sName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage>, MyListState<HomePage> {
  
  CmtsTitleInfo ctInfo;
  List<SignalData> sdList = new List();
  List<SignalData> noSdList = new List();
  List<Bigbad> bigbadList = new List();

  var selectArea = '新北市';

  ///取得cmts表資料
  _cmtsTitleData() async {
    ctInfo = null;
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
    sdList = [];
    noSdList = [];
    var res = await HomeDao.getQueryAllSNRSignalAPI();
    if (res != null && res.result) {
      setState(() {
        List<SignalData> list = res.data;
        for (int i = 0; i < list.length; i++) {
          var dic = list[i];
          if (dic.Name.contains("無對")) {
            noSdList.add(dic);
          } else {
            sdList.add(dic);
          }
        }
      });
      isLoading = false;
    }
  }
  ///取得重大list
  _bigbadData() async {
    bigbadList = [];
    var res = await BigbadDao.getQueryBigBadAPI();
    if (res != null && res.result) {
      setState(() {
        List<Bigbad> list = res.data;
        bigbadList = list;
        
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _cmtsTitleData();
    _signalData();
    _bigbadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get isRefreshFirst => false;

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
 
 
  ///區域dialog, ios樣式
  _showAlertSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(context: context, builder: (context) {
      var dialog = CupertinoActionSheet(
      title: Text(CommonUtils.getLocale(context).area_dialog_title),
      cancelButton: CupertinoActionSheetAction(onPressed: (){
        Navigator.pop(context,'cancel');
      },child: Text('取消'),),
      actions: <Widget>[
        CupertinoActionSheetAction(onPressed: (){
          setState(() {
            selectArea = '新北市';
          });
          Navigator.pop(context);
        },child: Text('新北市'),),
        CupertinoActionSheetAction(onPressed: (){
          setState(() {
            selectArea = '台北市';
          });
          Navigator.pop(context);
        },child: Text('台北市'),),
      ],
    );
    return dialog;
    });
  }
  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///自動縮放text
  _buildTextFontColor(String text, Color color) {
    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: MyScreen.homePageFontSize(context)),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  /// cmts talbe
  _buildCmtsTable() {
    var miniFontSize = MyScreen.homePageFontSize(context);
    if (miniFontSize < 11.0){
      miniFontSize = miniFontSize - 2;
    }
   
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
              style: TextStyle(fontSize: miniFontSize),
              minFontSize: 8.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_dowP
                  : CommonUtils.getLocale(context).home_cmtsTitle_dowP + ': ',
              style: TextStyle(fontSize: miniFontSize, color: Colors.purple),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_cut
                  : CommonUtils.getLocale(context).home_cmtsTitle_cut + ': ',
              style: TextStyle(fontSize: miniFontSize),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_major
                  : CommonUtils.getLocale(context).home_cmtsTitle_major +
                      ': ${ctInfo.MAJOR}',
              style: TextStyle(fontSize: miniFontSize, color: Colors.red),
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
              style: TextStyle(fontSize: miniFontSize, color: Colors.orange),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_watch
                  : CommonUtils.getLocale(context).home_cmtsTitle_watch + ': ',
              style: TextStyle(fontSize: miniFontSize, color: Colors.blue),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_fix2
                  : CommonUtils.getLocale(context).home_cmtsTitle_fix2 + ': ',
              style: TextStyle(fontSize: miniFontSize, color: Colors.pink),
              minFontSize: 1.0,
            ),
            new AutoSizeText(
              ctInfo == null
                  ? CommonUtils.getLocale(context).home_cmtsTitle_fix
                  : CommonUtils.getLocale(context).home_cmtsTitle_fix +
                      ': ${ctInfo.FIX}',
              style: TextStyle(fontSize: miniFontSize, color: Colors.red),
              minFontSize: 1.0,
            ),
          ],
        ),
      ],
    );
  }
  ///信號表頭
  _buildSignalHead() {
    return new Container(
      height: 40.0,
      color: Color(MyColors.hexFromStr('#f5ffe9')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_signal_area, Colors.black),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_signal_online, Colors.blue),
            )
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_signal_upP, Colors.black),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_signal_problem, Colors.pink),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_signal_percent,
              Colors.blue[300]),
            ),
          )
        ],
      ),
    );
  }

  List<GestureDetector> _listView() {
    var index = 0;
    return sdList.map((sd){
      var contrainer = Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                padding: EdgeInsets.all(5.0),
                child: Text(sd.Name)
              ),
            )
          ],
        ),
      );
      index = index + 1;
      final getstureDetector = GestureDetector(
        child: contrainer,
        onTap: () {
          print(123);
        },
      );
      return getstureDetector;
    }).toList();
  }

  ///signal list body
  _buildSignalBody() {
    var miniFontSize = MyScreen.homePageFontSize(context);
    var tableHeight = 120.0;
    final deviceHeight = MediaQuery.of(context).size.height;
    if (deviceHeight > 800) {
      tableHeight = 210.0;
    }
    return Container(
      height: tableHeight,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: new Container(
                height: 44.0,
                child: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: sdList == null
                          ? []
                          : <Widget>[
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  sdList[index].Name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: miniFontSize
                                  ),
                                )
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  sdList[index].OnLine,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: miniFontSize
                                  ),
                                ),
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  sdList[index].Bad,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: miniFontSize
                                  ),
                                ),
                                ),
                              ),
                              new Expanded(
                                child:  new Container(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                   sdList[index].OverPower,
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontSize: miniFontSize
                                   ),
                                )
                                ),
                              ),
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  sdList[index].Problem,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: miniFontSize
                                  ),
                                )
                                ),
                              ),
                              new Expanded(
                                child:  new Container(
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  '${((sdList[index].BadRate * 1000) / 10).toStringAsFixed(1)}%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:  Colors.blue[300],
                                    fontSize: miniFontSize
                                  ),
                                )
                              )   
                              )
                            ],
                    ),
                    _buildLine()
                  ],
                )),
            onTap: () {
              print('selected item -> ${index.toString()}');
              String cmtsCode = sdList[index].CMTSCode;
              String name = sdList[index].Name;
              String time = sdList[index].Time;
              NavigatorUtils.goAbnormalCard(context, cmtsCode, name, time);
            }
          );
        },
        itemCount: sdList.length,
      ),
    );
  }
  ///signal 底
  _buildSignalFooter() {
    var miniFontSize =MyScreen.homePageFontSize(context);

    var intVb = 0;
    var intFix = 0;
    var intOnline = 0;
    var intProblem = 0;
    var intOverPower = 0;
    var intBad = 0;
    var doubleRate = 0.0;
    if (sdList.length > 0) {
      for (int i = 0; i < sdList.length; i++) {
        var dic = sdList[i];
        intFix += int.parse(dic.AssignFix);
        intOnline += int.parse(dic.OnLine);
        intProblem += int.parse(dic.Problem);
        intOverPower += int.parse(dic.OverPower);
        intBad += int.parse(dic.Bad);
        doubleRate += dic.BadRate;
      }
    }
    return new Container(
      height: 40.0,
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Text(
                CommonUtils.getLocale(context).home_signal_total, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: miniFontSize
                ),
              )
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Text(
                "${intOnline}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: miniFontSize
                ),
              )
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Text(
                "${intBad}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: miniFontSize
                ),
              )
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Text(
                "${intOverPower}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: miniFontSize
                ),
              )
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Text(
                "${intProblem}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: miniFontSize
                ),
              )
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: new Text(
                "${(((doubleRate * 1000) / 10) / sdList.length).toStringAsFixed(1)}%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: miniFontSize
                ),
              )
            ),
          )
        ],
      ),
    );
  }
  ///位置錯誤
  _buildWrongPlace() {
    var miniFontSize = MyScreen.homePageFontSize(context);
    // if (miniFontSize < 11) {
    //   miniFontSize = miniFontSize - 2;
    // }
    var y = 0;
    var str = "";
    if (noSdList.length > 0) {
      for (int i = 0; i < noSdList.length; i++) {
        var dic = noSdList[i];
        str += "(${dic.Name}:${dic.OnLine})";
        y++;
        if (y == 2) {
          str += "\n";
        }
      }
      noSdList = [];
      print("無對應 -> ${str}");
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Text(
            str,
            style: TextStyle(fontSize: miniFontSize),
          )
        ],
      );
    }
  }
  ///重大信息
  _buildBigbadListView() {
    var miniFontSize = MyScreen.homePageFontSize(context);
    var tableHeight = 70.0;
    final deviceHeight = MediaQuery.of(context).size.height;
    if (deviceHeight > 800) {
      tableHeight = 110;
    }
    return new Container(
      height: tableHeight,
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: bigbadList == null ? [] : <Widget>[
                      new Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "${bigbadList[index].Name}-${bigbadList[index].CIF}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: miniFontSize
                            ),
                          )
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new Text(
                          bigbadList[index].DATE,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: miniFontSize
                          ),
                        )
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new Text(
                          bigbadList[index].Time,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: miniFontSize
                          ),
                        )
                      ),
                      new Container(
                        child: new Text(
                          "~",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: miniFontSize
                          ),
                        )
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          bigbadList[index].RTIME == null ? "--:--" : bigbadList[index].RTIME,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: miniFontSize
                          ),
                        )
                      )
                    ],
                  ),
                  _buildLine()
                ],
              )
            ),
          );
        },
        itemCount: bigbadList.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new StoreBuilder<SysState>(builder: (context, store) {
      return WillPopScope(
          onWillPop: () {
            return _dialogExitApp(context);
          },
          child: SafeArea(
            bottom: true,
            top: false,
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
                          minWidth: MyScreen.homePageBarButtonWidth(context),
                          child: new MyToolButton(
                            text: selectArea,
                            textColor: Colors.white,
                            color: Colors.transparent,
                            fontSize: MyScreen.homePageFontSize(context),
                            onPress: () {
                              _showAlertSheetController(context);
                            },
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MyScreen.homePageBarButtonWidth(context),
                          child: new MyToolButton(
                            text: "自移",
                            textColor: Colors.white,
                            color: Colors.transparent,
                            fontSize: MyScreen.homePageFontSize(context),
                            onPress: () {
                              print("123");
                            },
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MyScreen.homePageBarButtonWidth(context),
                          child: new MyToolButton(
                            text: "點數",
                            textColor: Colors.white,
                            color: Colors.transparent,
                            fontSize: MyScreen.homePageFontSize(context),
                            onPress: () {
                              print("123");
                            },
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MyScreen.homePageBarButtonWidth(context),
                          child: new MyToolButton(
                            text: "鎖HP",
                            textColor: Colors.white,
                            color: Colors.transparent,
                            fontSize: MyScreen.homePageFontSize(context),
                            mainAxisAlignment: MainAxisAlignment.start,
                            onPress: () {
                              print("123");
                            },
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MyScreen.homePageBarButtonWidth(context),
                          child: new MyToolButton(
                            text: sdList == null ?  "資料" : sdList[0].Time,
                            textColor: Colors.white,
                            color: Colors.transparent,
                            fontSize: MyScreen.homePageFontSize(context),
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
              body: isLoading ? showProgressLoading() : new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new Row(
                      ///裝button的row
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 60.0,
                          height: 35,
                          child: new MyToolButton(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.grey)),
                            text:
                                CommonUtils.getLocale(context).home_btn_bigbad,
                            color: Color(MyColors.hexFromStr("#fee9fa")),
                            fontSize: MyConstant.smallTextSize,
                            textColor: Colors.black,
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 60.0,
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
                          minWidth: 60.0,
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
                          minWidth: 60.0,
                          height: 35,
                          child: new MyToolButton(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.grey)),
                            text:
                                CommonUtils.getLocale(context).home_btn_problem,
                            color: Color(MyColors.hexFromStr("#fff7dc")),
                            fontSize: MyConstant.smallTextSize,
                            textColor: Colors.black,
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 60.0,
                          height: 35,
                          child: new MyToolButton(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.grey)),
                            text: CommonUtils.getLocale(context)
                                .home_btn_assignFix,
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
                    /// 高度1的分隔線
                    _buildLine(),
                    /// signal table head
                    _buildSignalHead(),
                    /// 高度1的分隔線
                    _buildLine(),
                    ///signal table body
                    _buildSignalBody(),
                    /// 高度1的分隔線
                    _buildLine(),
                    new Container(
                      alignment: Alignment(0, 0),
                      padding: EdgeInsets.only(left: 5.0),
                      // padding: EdgeInsets.all(10.0),
                      height: 40,
                      child: _buildWrongPlace(),
                    ),
                    /// 高度1的分隔線
                    _buildLine(),
                    /// signal table底
                    _buildSignalFooter(),
                    /// 高度1的分隔線
                    _buildLine(),
                    new Container(
                      padding: EdgeInsets.only(bottom: 1.0),
                      child: Text(
                        CommonUtils.getLocale(context).home_cmtsTitle_major,
                        style: TextStyle(

                          color: Colors.red,
                          fontSize: MyScreen.homePageFontSize(context)
                        ),  
                      ),
                    ),
                     /// 高度1的分隔線
                    _buildLine(),
                    _buildBigbadListView(),
                   
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
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: "刷新",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.homePageFontSize(context),
                        onPress: () {
                          isLoading = true;
                          setState(() {
                            _cmtsTitleData();
                            _signalData();
                            _bigbadData();
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: "分析",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.homePageFontSize(context),
                        onPress: () {
                          print("123");
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
                            style: TextStyle(fontSize: MyScreen.homePageFontSize(context)),
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
                        text: "設定",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.homePageFontSize(context),
                        onPress: () {
                          print("123");
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: "返回",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.homePageFontSize(context),
                        mainAxisAlignment: MainAxisAlignment.start,
                        onPress: () {
                          NavigatorUtils.goLogin(context);
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
    });
  }
}

