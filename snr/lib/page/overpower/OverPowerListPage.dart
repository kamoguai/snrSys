

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/dao/PublicworksDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';

/**
 * >51 列表頁
 * Date: 2019-04-23
 */
class OverPowerListPage extends StatefulWidget {
  @override
  _OverPowerListPageState createState() => _OverPowerListPageState();
}

class _OverPowerListPageState extends State<OverPowerListPage> with AutomaticKeepAliveClientMixin<OverPowerListPage>, MyListState<OverPowerListPage> {
   ///data 相關
  List<dynamic> dataArray = new List();
  var instCount = 0;
  var maintainCount = 0;
  var instFixCount = 0;
  var fixfixCount = 0;
  ///數值顏色
  var o_color = "";
  var o_color_zero = "";
  var i_color = "";
  var i_color_zero = "";
  ///數值加總
  var foCount_o = 0;
  var foCount_i = 0;
  var thCount_o = 0;
  var thCount_i = 0;
  var twCount_o = 0;
  var twCount_i = 0;
  var oneCount_o = 0;
  var oneCount_i = 0;
  var toCount_o = 0;
  var toCount_i = 0;

  @override
  bool get isRefreshFirst => false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getApiDataList();
  }

  @override
  void dispose() {
    super.dispose();
  }
  ///初始化數據
  initData() {
    dataArray = [];
    foCount_o = 0;
    foCount_i = 0;
    thCount_o = 0;
    thCount_i = 0;
    twCount_o = 0;
    twCount_i = 0;
    oneCount_o = 0;
    oneCount_i = 0;
    toCount_o = 0;
    toCount_i = 0;
  }
  ///取得api data
  getApiDataList() async {
    initData();
    var res = await PublicworksDao.getQueryOverTimeAnalyse();
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data["Data"];
        for (var dic in dataArray) {
          if (dic["four_o"] != null && dic["four_o"] != "") {
            foCount_o = foCount_o + int.parse(dic["four_o"]);
          }
          if (dic["three_o"] != null && dic["three_o"] != "") {
            thCount_o = thCount_o + int.parse(dic["three_o"]);
          }
          if (dic["two_o"] != null && dic["two_o"] != "") {
            twCount_o = twCount_o + int.parse(dic["two_o"]);
          }
          if (dic["one_o"] != null && dic["one_o"] != "") {
            oneCount_o = oneCount_o + int.parse(dic["one_o"]);
          }
          if (dic["total_o"] != null && dic["total_o"] != "") {
            toCount_o = toCount_o + int.parse(dic["total_o"]);
          }

          if (dic["four_i"] != null && dic["four_i"] != "") {
            foCount_i = foCount_i + int.parse(dic["four_i"]);
          }
          if (dic["three_i"] != null && dic["three_i"] != "") {
            thCount_i = thCount_i + int.parse(dic["three_i"]);
          }
          if (dic["two_i"] != null && dic["two_i"] != "") {
            twCount_i = twCount_i + int.parse(dic["two_i"]);
          }
          if (dic["one_i"] != null && dic["one_i"] != "") {
            oneCount_i = oneCount_i + int.parse(dic["one_i"]);
          }
          if (dic["total_i"] != null && dic["total_i"] != "") {
            toCount_i = toCount_i + int.parse(dic["total_i"]);
          }
         
        }
        o_color = res.data["O_Color"];
        o_color_zero = res.data["O_Color_Zero"];
        i_color = res.data["I_Color"] + "0";
        i_color_zero = res.data["I_Color_Zero"];
        isLoading = false;
      });
    }
  }

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///分隔線red
  _buildLineRed() {
    return new Container(
      height: 1.0,
      color: Colors.red,
    );
  }

  ///高分隔線
  _buildLineHeight() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線
  _buildLineHeightDouble() {
    return new Container(
      height: _titleHeight() * 2,
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切8份
  _deviceWidth8() {
    var width = MediaQuery.of(context).size.width;
    return width / 8;
  }

  ///取得裝置height切4分
  _deviceHeight4() {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  _listHeight() {
    var height = _deviceHeight4();
    return height / 5;
  }

  ///title height
  _titleHeight() {
    var height = _deviceHeight4();
    return height / 4;
  }

  ///自動字大小
  Widget _autoTextSize(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildOverPowerTitle1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fef5f6')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth8() * 2) - 1,
            child: _autoTextSize(
                '>51', Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_net, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(
                '4', Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(
                '3', Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(
                '2', Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(
                '1', Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8(),
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_total_s, Colors.blueAccent),
          ),
        ],
      ),
    );
  }

  ///publicList1
  Widget _buildOverPowerListItem1(BuildContext contex, int index) {
    var dic = dataArray[index];
    var apiColor_o1 = "";
    var apiColor_o2 = "";
    var apiColor_o3 = "";
    var apiColor_o4 = "";
    var apiColor_o5 = "";
    var apiColor_i1 = "";
    var apiColor_i2 = "";
    var apiColor_i3 = "";
    var apiColor_i4 = "";
    var apiColor_i5 = "";
    ///外網
    if (dic["four_o"] == "0") {
      apiColor_o4 = o_color_zero;
    }
    else {
      apiColor_o4 = o_color;
    }
    if (dic["three_o"] == "0") {
      apiColor_o3 = o_color_zero;
    }
    else {
      apiColor_o3 = o_color;
    }
    if (dic["two_o"] == "0") {
      apiColor_o2 = o_color_zero;
    }
    else {
      apiColor_o2 = o_color;
    }
    if (dic["one_o"] == "0") {
      apiColor_o1 = o_color_zero;
    }
    else {
      apiColor_o1 = o_color;
    }
    if (dic["total_o"] == "0") {
      apiColor_o5 = o_color_zero;
    }
    else {
      apiColor_o5 = o_color;
    }
    ///內網
    if (dic["four_i"] == "0") {
      apiColor_i4 = i_color_zero;
    }
    else {
      apiColor_i4 = i_color;
    }
    if (dic["three_i"] == "0") {
      apiColor_i3 = i_color_zero;
    }
    else {
      apiColor_i3 = i_color;
    }
    if (dic["two_i"] == "0") {
      apiColor_i2 = i_color_zero;
    }
    else {
      apiColor_i2 = i_color;
    }
    if (dic["one_i"] == "0") {
      apiColor_i1 = i_color_zero;
    }
    else {
      apiColor_i1 = i_color;
    }
    if (dic["total_i"] == "0") {
      apiColor_i5 = i_color_zero;
    }
    else {
      apiColor_i5 = i_color;
    }
    return GestureDetector(
      child: Container(
        height: _listHeight() * 2,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: (_deviceWidth8() * 2) - 1,
              child: _autoTextSize(dic["Area"] ?? "", Colors.black),
            ),
            _buildLineHeightDouble(),
            Container(
              width: _deviceWidth8() * 6,
              child: Column(
                children: <Widget>[
                  Container(
                    height: _listHeight() - 1,
                    color: Color(MyColors.hexFromStr("#f4fdff")),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(CommonUtils.getLocale(context).text_extranet, Colors.blueAccent),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["four_o"], Color(MyColors.hexFromStr(apiColor_o4))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["three_o"], Color(MyColors.hexFromStr(apiColor_o3))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["two_o"], Color(MyColors.hexFromStr(apiColor_o2))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["one_o"], Color(MyColors.hexFromStr(apiColor_o1))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8(),
                          child: _autoTextSize(dic["total_o"], Color(MyColors.hexFromStr(apiColor_o5))),
                        ),
                      ],
                    ),
                  ),
                  _buildLine(),
                  Container(
                    height: _listHeight() - 1,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(CommonUtils.getLocale(context).text_intranet, Colors.black),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["four_i"], Color(MyColors.hexFromStr(apiColor_i4))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["three_i"], Color(MyColors.hexFromStr(apiColor_i3))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["two_i"], Color(MyColors.hexFromStr(apiColor_i2))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8() - 1,
                          child: _autoTextSize(dic["one_i"], Color(MyColors.hexFromStr(apiColor_i1))),
                        ),
                        _buildLineHeight(),
                        Container(
                          width: _deviceWidth8(),
                          child: _autoTextSize(dic["total_i"], Color(MyColors.hexFromStr(apiColor_i5))),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
      onTap: () {
        NavigatorUtils.goOverPowerDetail(context);
      },
    );
  }

  ///public list
  Widget _buildOverPowerList1() {
    Widget publicList;
    if (dataArray.length > 0) {
      publicList = Expanded(
        // height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildOverPowerListItem1,
          itemCount: dataArray.length,
        ),
      );
    } else {
      publicList = Container(child: buildEmpty());
    }
    return publicList;
  }

  ///work bottom
  Widget _buildOverPowerBottom1() {
    return new Container(
      height: _listHeight() * 2,
      color: Color(MyColors.hexFromStr('#f5ffe9')),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth8() * 2) - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_total, Colors.blueAccent),
          ),
          _buildLineHeightDouble(),
          Container(
            width: _deviceWidth8() * 6,
            child: Column(
              children: <Widget>[
                Container(
                  height: _listHeight() - 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize(CommonUtils.getLocale(context).text_extranet, Colors.blueAccent),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$foCount_o', Colors.red),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$thCount_o', Colors.red),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$twCount_o', Colors.red),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$oneCount_o', Colors.red),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8(),
                        child: _autoTextSize('$toCount_o', Colors.red),
                      ),
                    ],
                  ),
                ),
                _buildLine(),
                Container(
                  height: _listHeight() - 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize(CommonUtils.getLocale(context).text_intranet, Colors.black),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$foCount_i', Colors.black),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$thCount_i', Colors.black),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$twCount_i', Colors.black),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8() - 1,
                        child: _autoTextSize('$oneCount_i', Colors.black),
                      ),
                      _buildLineHeight(),
                      Container(
                        width: _deviceWidth8(),
                        child: _autoTextSize('$toCount_i', Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  ///將body寫在這裡
  Widget getBody() {
    return isLoading
        ? showProgressLoading()
        : new Column(
            children: <Widget>[
              ///headtilte
              _buildOverPowerTitle1(),
              _buildLineRed(),
              ///bodylist
              _buildOverPowerList1(),
              _buildLineRed(),
              ///bottom
              _buildOverPowerBottom1(),
              _buildLine()
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              new Expanded(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          isLoading = true;
                          setState(() {
                            getApiDataList();
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: CommonUtils.getLocale(context).text_overTime,
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                          NavigatorUtils.goOverTimeDetail(context, dataType: 'OverTime');
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: CommonUtils.getLocale(context).text_noDsflow,
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                          NavigatorUtils.goOverTimeDetail(context, dataType: 'NoTime');
                        },
                      ),
                    ),
                    Text('資料',
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context),
                            color: Colors.white)
                    ),
                    
                  ],
                ),
              )
            ],
            leading: Container(),
          ),

          ///body
          body: getBody(),

          ///toolBar
          bottomNavigationBar: new Material(
            color: Theme.of(context).primaryColor,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTheme(
                  child: new MyToolButton(
                    padding: EdgeInsets.all(1.0),
                    text: CommonUtils.getLocale(context).text_refresh,
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: MyScreen.normalPageFontSize(context),
                    onPress: () {
                      isLoading = true;
                      setState(() {
                        getApiDataList();
                      });
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
                        fontSize: MyScreen.normalPageFontSize(context)),
                  ),
                  onPressed: () {
                    print(123);
                  },
                )),
                ButtonTheme(
                  child: new MyToolButton(
                    padding: EdgeInsets.all(1.0),
                    text: CommonUtils.getLocale(context).text_back,
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: MyScreen.normalPageFontSize(context),
                    mainAxisAlignment: MainAxisAlignment.start,
                    onPress: () {
                      if (isLoading) {
                        Fluttertoast.showToast(
                            msg: CommonUtils.getLocale(context).loading_text);
                        return;
                      }
                      setState(() {
                        //返回上一頁
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
