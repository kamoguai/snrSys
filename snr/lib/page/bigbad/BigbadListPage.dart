

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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Future.delayed(const Duration(seconds: 1), () {
      getApiDataList();
    });
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
    else {
      setState(() {
        isLoading = false;
      }); 
      
    }
  }

  ///title height
  @override
  titleHeight() {
    var height = deviceHeight4();
    return height / 4.8;
  }

  ///自動字大小
  @override
  Widget autoTextSize(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  ///自動字大小靠左
  @override
  Widget autoTextSizeLeft(text, color) {
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
      height: titleHeight(),
      color: Color(MyColors.hexFromStr('#fafff2')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).text_status, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).home_signal_online, Colors.blueAccent),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).home_btn_upP, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).home_btn_problem, Colors.pink),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6(),
            child: autoTextSize(
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
        height: listHeight() * 4,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
        child: Column(
          children: <Widget>[
            Container(
              height: listHeight() - 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize(CommonUtils.getLocale(context).text_sendReoprt, Colors.black),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize(dic.Online ?? "", Colors.blue),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize(dic.Bad ?? "", Colors.red),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize('', Colors.red),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize('', Colors.red),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6(),
                    child: autoTextSize('', Colors.black),
                  ),
                ],
              ),
            ),
            buildLine(),
            Container(
              height: listHeight() - 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize(CommonUtils.getLocale(context).text_situation, Colors.black),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize(dic.Online ?? "", Colors.blue),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize(dic.Bad ?? "", Colors.black),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize('', Colors.black),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6() - 1,
                    child: autoTextSize('', Colors.black),
                  ),
                  buildLineHeight(),
                  Container(
                    width: deviceWidth6(),
                    child: autoTextSize('', Colors.blueAccent),
                  ),
                ],
              ),
            ),
            buildLine(),
            Container(
              height: listHeight() - 1,
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      autoTextSize(dic.DisplayName, Colors.black),
                      SizedBox(width: 5.0,),
                      autoTextSize(dic.DATE, Colors.green),
                      SizedBox(width: 2.0,),
                      autoTextSize(dic.Time, Colors.red),
                      autoTextSize('~', Colors.black),
                      autoTextSize(dic.RTIME, Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            buildLine(),
            Container(
              height: listHeight() - 1,
              alignment: Alignment.centerLeft,
              color: Color(MyColors.hexFromStr('#f2f2f2')),
              child: ListView(
                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  autoTextSizeLeft('', Colors.grey),
                ],
              )
            ),
            buildLineRed()
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
        height: deviceHeight4() * 1.6,
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
      height: titleHeight(),
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (deviceWidth7() * 2) - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).text_position, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth7() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).text_thisDay, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth7() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).text_thisWeek, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth7() - 1,
            child: autoTextSize(
                CommonUtils.getLocale(context).text_thisMonth, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: (deviceWidth7() * 2),
            child: autoTextSize(
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
        height: titleHeight(),
        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: (deviceWidth7() * 2) - 1,
              child: autoTextSize(dic["Name"] ?? "", Colors.black),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth7() - 1,
              child: autoTextSize(dic["DCOUNT"], Colors.black),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth7() - 1,
              child: autoTextSize(dic["WCOUNT"], Colors.black),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth7() - 1,
              child: autoTextSize(dic["MCOUNT"], Colors.black),
            ),
            buildLineHeight(),
            Container(
              width: (deviceWidth7() * 2),
              child: autoTextSize(fDate + "\n" + dic["STIME"] + "~" + dic["RTIME"], Colors.black),
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
        ? showLoadingAnime(context)
        : new Column(
            children: <Widget>[
              ///headtilte
              _buildBigBadTitle1(),
              buildLine(),
              ///bodylist
              _buildBigBadList1(),
              SizedBox(height: 10.0,),
              buildLine(),
              _buildBigBadTitle2(),
              buildLine(),
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
            title: Text(CommonUtils.getLocale(context).text_sort, style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消', style: TextStyle(fontSize: ScreenUtil().setSp(20))),
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
                child: Text(CommonUtils.getLocale(context).text_all, style: TextStyle(fontSize: ScreenUtil().setSp(20))),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_bq;
                    isLoading = true;
                    getApiDataList();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_bq, style: TextStyle(fontSize: ScreenUtil().setSp(20))),
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
                child: Text(CommonUtils.getLocale(context).text_sc, style: TextStyle(fontSize: ScreenUtil().setSp(20))),
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
                child: Text(CommonUtils.getLocale(context).text_xz, style: TextStyle(fontSize: ScreenUtil().setSp(20))),
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
                child: Text(CommonUtils.getLocale(context).text_tc, style: TextStyle(fontSize: ScreenUtil().setSp(20))),
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
                child: Text(CommonUtils.getLocale(context).text_lu, style: TextStyle(fontSize: ScreenUtil().setSp(20))),
              ),
            ],
          );
          
          return dialog;
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
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
                Container(
                  height: 30,
                  child: FlatButton.icon(
                    icon: Image.asset('static/images/24.png'),
                    color: Colors.transparent,
                    label: Text(''),
                    onPressed: (){
                      NavigatorUtils.goLogin(context);
                    },
                  ),
                ),
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
