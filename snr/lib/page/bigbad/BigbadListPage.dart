

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:snr/common/dao/BigBadDao.dart';
import 'package:snr/common/model/BigBad.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';
/**
 * 重大 列表頁
 * Date: 2019-04-24
 */
class BigBadListPage extends StatefulWidget {
  @override
  _BigBadListPageState createState() => _BigBadListPageState();
}

class _BigBadListPageState extends State<BigBadListPage> with AutomaticKeepAliveClientMixin<BigBadListPage>, MyListState<BigBadListPage> {
  ///data 相關
  List<dynamic> dataArray = new List();
  List<Bigbad> bigbadList = new List();
  var instCount = 0;
  var maintainCount = 0;
  var instFixCount = 0;
  var fixfixCount = 0;
  ///地區
  var selectCity = "";

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
   
  }
  ///取得api data
  getApiDataList() async {
    initData();
    var res = await BigbadDao.getQueryBigBadAPI();
    if (res != null && res.result) {
      var res2 = await BigbadDao.getQueryBigBadHistory(city: strCity);
      if (res2 != null && res2.result) {
        setState(() {
          bigbadList = res.data;
          dataArray = res2.data;
          isLoading = false;
        });
      }
      else {
        setState(() {
          bigbadList = res.data;
          dataArray = [];
          isLoading = false;
        });
      }
      
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

  ///取得裝置width並切6份
  _deviceWidth6() {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }

  ///取得裝置width並切7份
  _deviceWidth7() {
    var width = MediaQuery.of(context).size.width;
    return width / 7;
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
    return height / 4.8;
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
  ///自動字大小靠左
  Widget _autoTextSizeLeft(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.left,
    );
  }
  ///title1
  Widget _buildBigBadTitle1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fafff2')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_status, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_signal_online, Colors.blueAccent),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_btn_upP, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_btn_problem, Colors.pink),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(
                CommonUtils.getLocale(context).home_signal_percent, Colors.blueAccent),
          ),
        ],
      ),
    );
  }

  ///publicList1
  Widget _buildBigBadListItem1(BuildContext contex, int index) {
    var dic = bigbadList[index];
    return GestureDetector(
      child: Container(
        height: _listHeight() * 4,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
        child: Column(
          children: <Widget>[
            Container(
              height: _listHeight() - 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize(CommonUtils.getLocale(context).text_sendReoprt, Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize(dic.Online ?? "", Colors.blue),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize(dic.Bad ?? "", Colors.red),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize('上P', Colors.red),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize('問題', Colors.red),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6(),
                    child: _autoTextSize('％', Colors.black),
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
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize(CommonUtils.getLocale(context).text_situation, Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize(dic.Online ?? "", Colors.blue),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize(dic.Bad ?? "", Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize('上P', Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6() - 1,
                    child: _autoTextSize('問題', Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth6(),
                    child: _autoTextSize('％', Colors.blueAccent),
                  ),
                ],
              ),
            ),
            _buildLine(),
            Container(
              height: _listHeight() - 1,
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _autoTextSize(dic.DisplayName, Colors.black),
                      SizedBox(width: 5.0,),
                      _autoTextSize(dic.DATE, Colors.green),
                      SizedBox(width: 2.0,),
                      _autoTextSize(dic.Time, Colors.red),
                      _autoTextSize('~', Colors.black),
                      _autoTextSize(dic.RTIME, Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            _buildLine(),
            Container(
              height: _listHeight() - 1,
              alignment: Alignment.centerLeft,
              color: Color(MyColors.hexFromStr('#f2f2f2')),
              child: ListView(
                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _autoTextSizeLeft('查修回報查修回報查修回報查修回報查修回報查修回報查修回報查修回報查修回報查修回報查修回報查修回報', Colors.grey),
                ],
              )
            ),
            _buildLineRed()
          ],
        )
        
      ),
      onTap: () {
        // NavigatorUtils.goBigBadDetail(context);
      },
    );
  }

  ///public list
  Widget _buildBigBadList1() {
    Widget publicList;
    if (bigbadList.length > 0) {
      publicList = Container(
        height: _deviceHeight4() * 1.6,
        child: ListView.builder(
          itemBuilder: _buildBigBadListItem1,
          itemCount: bigbadList.length,
        ),
      );
    } else {
      publicList = Container(child: buildEmpty());
    }
    return publicList;
  }

  ///title2
  Widget _buildBigBadTitle2() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth7() * 2) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_position, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth7() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_thisDay, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth7() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_thisWeek, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth7() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_thisMonth, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: (_deviceWidth7() * 2),
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_time, Colors.black),
          ),
        ],
      ),
    );
  }

  ///bodyItem2
  Widget _buildBigBadListItem2(BuildContext context, int index) {
    var dic = dataArray[index];
    var dateToStr = new DateFormat("yyyy-MM-dd").parse(dic["DATE"]);
    var fDate = formatDate(dateToStr, [yy,'-',mm,'-',dd]);
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
              width: (_deviceWidth7() * 2) - 1,
              child: _autoTextSize(dic["Name"] ?? "", Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth7() - 1,
              child: _autoTextSize(dic["DCOUNT"], Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth7() - 1,
              child: _autoTextSize(dic["WCOUNT"], Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth7() - 1,
              child: _autoTextSize(dic["MCOUNT"], Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: (_deviceWidth7() * 2),
              child: _autoTextSize(fDate + "\n" + dic["STIME"] + "~" + dic["RTIME"], Colors.black),
            ),
          ],
        ),
      ),
      onTap: () {
        NavigatorUtils.goBigBadDetail(context);
      },
      onLongPress: () {
        print('longTap');
      },
    );
  }

  ///public list
  Widget _buildBigBadList2() {
    Widget publicList;
    if (dataArray.length > 0) {
      publicList = Expanded(
        child: ListView.builder(
          itemBuilder: _buildBigBadListItem2,
          itemCount: dataArray.length,
        ),
      );
    } else {
      publicList = Container(child: buildEmpty());
    }
    return publicList;
  }

  ///將body寫在這裡
  Widget getBody() {
    return isLoading
        ? showProgressLoading()
        : new Column(
            children: <Widget>[
              ///headtilte
              _buildBigBadTitle1(),
              _buildLine(),
              ///bodylist
              _buildBigBadList1(),
              SizedBox(height: 10.0,),
              _buildLine(),
              _buildBigBadTitle2(),
              _buildLine(),
              _buildBigBadList2()
            ],
          );
  }
   ///地區dialog, ios樣式
  _showCityAlertSheetController(BuildContext context) {
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
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = '';
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_all),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_bq;;
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_bq),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_sc;;
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_sc),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_xz;;
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_xz),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_tc;;
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_tc),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_lu;
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_lu),
              ),
            ],
          );
          
          return dialog;
        }
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
                        text: '新北市▼',
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                        
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: strCity == "" ?  '區:' + CommonUtils.getLocale(context).text_all : strCity,
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                          _showCityAlertSheetController(context);
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: '重大異常',
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                          
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
                    'DCTV',
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
                        clearData();
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
