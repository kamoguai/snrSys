import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/dao/AssignFixDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyToolBarButton.dart';

/**
 * 派修列表頁面
 * Date: 2019-04-12
 */
class AssignFixListPage extends StatefulWidget {


  @override
  _AssignFixListPageState createState() => _AssignFixListPageState();
}

class _AssignFixListPageState extends State<AssignFixListPage> with AutomaticKeepAliveClientMixin<AssignFixListPage>, MyListState<AssignFixListPage> {
  ///data 相關
  List<dynamic> dataArray = new List();
  List<dynamic> dataArray2 = new List();
  int fixTotal = 0;
  int cutTotal = 0;
  int fix2Total = 0;
  int watchTotal = 0;
  int countTotal = 0;
  String dataTime = "";

  ///取得data api
  getApiDataList() async {
    fixTotal = 0;
    cutTotal = 0;
    fix2Total = 0;
    watchTotal = 0;
    countTotal = 0;
    var res = await AssignFixDao.getQueryAssignFixList();
    var res2 = await AssignFixDao.getBuildAnalyse('FIX');
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data;
        for (var dic in dataArray) {
          if (dic["FIX"] != null && dic["FIX"] != "") {
            fixTotal = fixTotal + int.parse(dic["FIX"]);
          }
          if (dic["CUT"] != null && dic["CUT"] != "") {
            cutTotal = cutTotal + int.parse(dic["CUT"]);
          }
          if (dic["FIX2"] != null && dic["FIX2"] != "") {
            fix2Total = fix2Total + int.parse(dic["FIX2"]);
          }
          if (dic["WATCH"] != null && dic["WATCH"] != "") {
            watchTotal = watchTotal + int.parse(dic["WATCH"]);
          }
          if (dic["TOTAL"] != null && dic["TOTAL"] != "") {
            countTotal = countTotal + int.parse(dic["TOTAL"]);
          }
          if (dic["UTime"] != null && dic["UTime"] != "") {
            dataTime = dic["UTime"];
          }
        }
        var time = dataArray[0]["UTime"];
        DateTime dt = DateTime.parse(time);
        var timeStr = formatDate(dt, [hh, ':', nn]);
        dataTime = timeStr;
      });
    }
    if (res2 != null && res2.result) {
      setState(() {
        dataArray2 = res2.data;
      });
    }
    if (dataArray != [] && dataArray2 != []) {
      isLoading = false;
    }
  }

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
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
  _buildRedLineHeight() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.red,
    );
  }

  ///取得裝置width並切6份
  _deviceWidth6() {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }

  ///取得裝置width並切6份
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

  ///間隔8
  _dummyHeight() {
    return SizedBox(
      height: 8.0,
    );
  }

  ///自動字大小
  Widget _autoTextSize(text, style) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  ///list title
  Widget _buildAssignFixListHeader1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fef5f6')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize('CMTS',
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_btn_assignFix,
                TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_fix2,
                TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_cut,
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_watch,
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).text_total_s,
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignFixListItem(BuildContext context, int index) {
    var dic = dataArray[index];
    return GestureDetector(
      child: Container(
        height: _listHeight(),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["Name"], TextStyle(color: Colors.black)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["FIX"], TextStyle(color: Colors.brown)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["FIX2"], TextStyle(color: Colors.brown)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["CUT"], TextStyle(color: Colors.blue)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["WATCH"], TextStyle(color: Colors.blue)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6(),
              child:
                  _autoTextSize(dic["TOTAL"], TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      onTap: () {
        print('cell click');
        NavigatorUtils.goAssignFixDetail(context);
      },
    );
  }

  Widget _buildAssignFixListBody() {
    Widget assignFixList;
    if (dataArray.length > 0) {
      assignFixList = Container(
        height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildAssignFixListItem,
          itemCount: dataArray.length,
        ),
      );
    } else {
      assignFixList = Container(
        child: buildEmpty(),
      );
    }
    return assignFixList;
  }

  ///list bottom
  Widget _buildAssignFixListBottom1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fce7f8')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_total,
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize("$fixTotal",
                TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize("$fix2Total",
                TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize("$cutTotal",
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize("$watchTotal",
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize("$countTotal",
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  ///building title
  Widget _buildBuildingListHeader() {
    return new Container(
      color: Color(MyColors.hexFromStr("#f2f2f2f2")),
      height: _titleHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth8() * 3) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_buildingName,
                TextStyle(
                  color: Colors.black,
                )),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_total_s,
                TextStyle(
                  color: Colors.black,
                )),
          ),
          _buildRedLineHeight(),
          Container(
            width: (_deviceWidth8()) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_cmtsTitle_fix,
                TextStyle(
                  color: Colors.black,
                )),
          ),
          _buildLineHeight(),
          Container(
            width: (_deviceWidth8()) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_fix2,
                TextStyle(
                  color: Colors.black,
                )),
          ),
          _buildLineHeight(),
          Container(
            width: (_deviceWidth8()) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_cut,
                TextStyle(
                  color: Colors.black,
                )),
          ),
          _buildLineHeight(),
          Container(
            width: (_deviceWidth8()),
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_watch,
                TextStyle(
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }

  ///building item
  Widget _buildBuildingListItem(BuildContext context, int index) {
    var dic = dataArray2[index];
    return GestureDetector(
      child: Container(
        height: _listHeight(),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: (_deviceWidth8() * 3) - 1,
              child: _autoTextSize(
                  dic["BuildingName"],
                  TextStyle(
                    color: Colors.black,
                  )),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth8() - 1,
              child: _autoTextSize(
                  dic["TOTAL"],
                  TextStyle(
                    color: Colors.black,
                  )),
            ),
            _buildRedLineHeight(),
            Container(
              width: (_deviceWidth8()) - 1,
              child: _autoTextSize(
                  dic["FIX"],
                  TextStyle(
                    color: Colors.black,
                  )),
            ),
            _buildLineHeight(),
            Container(
              width: (_deviceWidth8()) - 1,
              child: _autoTextSize(
                  dic["FIX2"] ?? "0",
                  TextStyle(
                    color: Colors.black,
                  )),
            ),
            _buildLineHeight(),
            Container(
              width: (_deviceWidth8()) - 1,
              child: _autoTextSize(
                  dic["CUT"] ?? "0",
                  TextStyle(
                    color: Colors.black,
                  )),
            ),
            _buildLineHeight(),
            Container(
              width: (_deviceWidth8()),
              child: _autoTextSize(
                  dic["WATCH"] ?? "0",
                  TextStyle(
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  ///building list
  Widget _buildBuildingListBody() {
    Widget buildingList;
    if (dataArray2 != null && dataArray2.length > 0) {
      buildingList = Expanded(
        child: ListView.builder(
          itemBuilder: _buildBuildingListItem,
          itemCount: dataArray2.length,
        ),
      );
    } else {
      buildingList = Container(child: buildEmpty());
    }
    return buildingList;
  }

  ///widget body
  Widget getBody() {
    if (isLoading) {
      return showProgressLoading();
    } else {
      return Column(
        children: <Widget>[
          _buildAssignFixListHeader1(),
          _buildLine(),
          _buildAssignFixListBody(),
          _buildLine(),
          _buildAssignFixListBottom1(),
          _buildLine(),
          _dummyHeight(),
          _buildLine(),
          _buildBuildingListHeader(),
          _buildLine(),
          _buildBuildingListBody()
        ],
      );
    }
  }

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

  @override
  bool get isRefreshFirst => false;

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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: CommonUtils.getLocale(context).home_btn_assignFix,
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
                  SizedBox(),
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
                      'DCTV',
                      style: TextStyle(
                          fontSize: MyScreen.homePageFontSize(context)),
                    ),
                    onPressed: () {
                      print(123);
                    },
                  )),
                  SizedBox(),
                  Text('資料: ${dataTime}',
                      style: TextStyle(
                          fontSize: MyScreen.normalPageFontSize(context),
                          color: Colors.white)),
                ],
              ),
            )
          ],
        ),
        body: getBody(),
        bottomNavigationBar: new Material(
          color: Theme.of(context).primaryColor,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: CommonUtils.getLocale(context).text_refresh,
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: MyScreen.homePageFontSize(context),
                  onPress: () {
                    getApiDataList();
                  },
                ),
              ),
              ButtonTheme(
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: '扣點',
                  textColor: Colors.yellow,
                  color: Colors.transparent,
                  fontSize: MyScreen.homePageFontSize(context),
                  onPress: () {},
                ),
              ),
              ButtonTheme(
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2.0,
                    color: Colors.grey[700],
                    style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: '完工統計',
                  textColor: Colors.white,
                  color: Colors.orange[400],
                  fontSize: MyScreen.homePageFontSize(context),
                  mainAxisAlignment: MainAxisAlignment.start,
                  onPress: () {
                    NavigatorUtils.goFinishedStatistic(context);
                  },
                ),
              ),
              ButtonTheme(
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: '工務',
                  textColor: Colors.yellow,
                  color: Colors.transparent,
                  fontSize: MyScreen.homePageFontSize(context),
                  onPress: () {},
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
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
