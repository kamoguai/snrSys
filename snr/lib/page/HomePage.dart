import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/localization/DefaultLocalizations.dart';
import 'package:snr/common/redux/SysState.dart';
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
import 'package:snr/widget/MyCardItem.dart';
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

  var selectArea;

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
        // sdList = res.data;
      });
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
    _cmtsTitleData();
    _signalData();
    _bigbadData();
    // areaItemList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get isRefreshFirst => false;

  // @override
  // void didChangeDependencies() {
  //   setState(() {
  //     selectArea =AreaSelector(context)[0];
  //   });
  //   super.didChangeDependencies();
  // }
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

  List<DropdownMenuItem> areaItemList() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem item1 = new DropdownMenuItem(
      value: "新北市",
      child: new Text("新北市"),
    );
    DropdownMenuItem item2 = new DropdownMenuItem(
      value: "台北市",
      child: new Text("台北市"),
    );
    items.add(item1);
    items.add(item2);
    return items;
  }

  ///頁面上方下拉選單
  _renderHeader(Store<SysState> store) {
    if (selectArea == null) {
      return Container();
    }
    return new MyCardItem(
      color: store.state.themeData.primaryColor,
      margin: EdgeInsets.all(10.0),
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: new Padding(
        padding:
            new EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        child: new Row(
          children: <Widget>[
            _renderHeaderPopItem(selectArea.name, AreaSelector(context),
                (AreaCodeModel result) {
              setState(() {
                selectArea = result;
              });
            })
          ],
        ),
      ),
    );
  }

  _renderHeaderPopItem(String data, List<AreaCodeModel> list,
      PopupMenuItemSelected<AreaCodeModel> onSelected) {
    return new Expanded(
      child: new PopupMenuButton<AreaCodeModel>(
        child: new Center(
            child: new Text(data, style: MyConstant.middleTextWhite)),
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return _renderHeaderPopItemChild(list);
        },
      ),
    );
  }

  _renderHeaderPopItemChild(List<AreaCodeModel> data) {
    List<PopupMenuEntry<AreaCodeModel>> list = new List();
    for (AreaCodeModel item in data) {
      list.add(PopupMenuItem<AreaCodeModel>(
        value: item,
        child: new Text(item.name),
      ));
    }
    return list;
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
      style: TextStyle(color: color, fontSize: _fontSize()),
      minFontSize: 9.0,
      textAlign: TextAlign.center,
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
    return Container(
      height: 120,
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
                                child: _buildTextFontColor(
                                  sdList[index].Name, Colors.black),
                              ),
                              ),
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: _buildTextFontColor(
                                  sdList[index].OnLine, Colors.blue),
                              ),
                              ),
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: _buildTextFontColor(
                                  sdList[index].Bad, Colors.red),
                              ),
                              ),
                              new Expanded(
                                child:  new Container(
                                padding: EdgeInsets.all(5.0),
                                child: _buildTextFontColor(
                                  sdList[index].OverPower, Colors.black),
                              ),
                              ),
                              new Expanded(
                                child: new Container(
                                padding: EdgeInsets.all(5.0),
                                child: _buildTextFontColor(
                                  sdList[index].Problem, Colors.pink),
                              ),
                              ),
                              new Expanded(
                                child:  new Container(
                                padding: EdgeInsets.all(5.0),
                          
                                child: _buildTextFontColor(
                                  '${((sdList[index].BadRate * 1000) / 10).toStringAsFixed(1)}%',
                                  Colors.blue[300]),
                              )   
                              )
                                                                               
                            ],
                    ),
                    _buildLine()
                  ],
                )),
            onTap: () {
              print('selected item -> ${index.toString()}');
              NavigatorUtils.goAbnormalCard(context);
            }
          );
        },
        itemCount: sdList.length,
      ),
    );
  }
  ///signal 底
  _buildSignalFooter() {
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
              child: _buildTextFontColor(
              CommonUtils.getLocale(context).home_signal_total, Colors.black),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor("${intOnline}", Colors.blue),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor("${intBad}", Colors.red),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor("${intOverPower}", Colors.black),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor("${intProblem}", Colors.pink),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: _buildTextFontColor("${(((doubleRate * 1000) / 10) / sdList.length).toStringAsFixed(1)}%",
              Colors.blue[300]),
            ),
          )
        ],
      ),
    );
  }
  ///位置錯誤
  _buildWrongPlace() {
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
      return Row(
        children: <Widget>[
          AutoSizeText(
            str,
            textAlign: TextAlign.left,
            minFontSize: 9.0,
            maxFontSize: 16.0,
          ),
        ],
      );
    }
  }
  ///重大信息
  _buildBigbadListView() {
    return new Container(
      height: 50.0,
      child: new ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: new Container(
              height: 40.0,
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: bigbadList == null ? [] : <Widget>[
                      new Container(
                          padding: EdgeInsets.all(5.0),
                          child: _buildTextFontColor("${bigbadList[index].Name}-${bigbadList[index].CIF}", Colors.black),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: _buildTextFontColor(bigbadList[index].DATE, Colors.black),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: _buildTextFontColor(bigbadList[index].Time, Colors.red),
                      ),
                      new Container(
                        child: _buildTextFontColor("~", Colors.black)
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: _buildTextFontColor(bigbadList[index].RTIME == null ? "--:--" : bigbadList[index].RTIME, Colors.blue),
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
                        // new DropdownButtonHideUnderline(
                        //   child: new DropdownButton(
                        //   hint: new Text('新北市'),
                        //   value: selectArea,
                        //   items: areaItemList(),
                        //   // style: TextStyle( fontSize: fontSize),
                        //   onChanged: (T){
                        //     setState(() {
                        //       selectArea = T;
                        //     });
                        //   },
                        // ),
                        // ),

                        ButtonTheme(
                          minWidth: 60.0,
                          child: new MyToolButton(
                            text: "新北市",
                            textColor: Colors.white,
                            color: Colors.transparent,
                            fontSize: fontSize,
                            onPress: () {
                              _renderHeader(store);
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
                            text:
                                CommonUtils.getLocale(context).home_btn_bigbad,
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
                            text:
                                CommonUtils.getLocale(context).home_btn_problem,
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
                      height: 20.0,
                      child: Text(
                        CommonUtils.getLocale(context).home_cmtsTitle_major,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: fontSize
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
                      minWidth: 60.0,
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: "刷新",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: fontSize,
                        onPress: () {
                          showRefreshLoading();
                          setState(() {
                            _cmtsTitleData();
                            _signalData();
                            _bigbadData();
                          });
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
                            style: TextStyle(fontSize: fontSize),
                          ),
                          onPressed: () {
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

class AreaCodeModel {
  final String name;
  final String value;

  AreaCodeModel(this.name, this.value);
}

AreaSelector(BuildContext context) {
  return [AreaCodeModel("新北市", "新北市"), AreaCodeModel("台北市", "台北市")];
}
