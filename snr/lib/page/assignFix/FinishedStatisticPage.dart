

import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/dao/AssignFixDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyToolBarButton.dart';
/**
 * 完工列表頁面
 * Date: 2019-04-19
 */
class FinishedStatisticPage extends StatefulWidget {



  @override
  _FinishedStatisticPageState createState() => _FinishedStatisticPageState();
}

class _FinishedStatisticPageState extends State<FinishedStatisticPage> with AutomaticKeepAliveClientMixin<FinishedStatisticPage>, MyListState<FinishedStatisticPage> {
  
  final nowTime = DateTime.now();
  List<dynamic> dataArray = new List();
  int totalCount = 0;
  int mCount = 0;
  int dCount = 0;
  int minusCount = 0;
  int bigBadCount = 0;
  int pipeCount = 0;
  //所選日期
  var selectDate = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
  ///是否是今日
  var isToday = false;
  ///取得api
  getApiDataList() async{
    totalCount = 0;
    mCount = 0;
    dCount = 0;
    minusCount = 0;
    bigBadCount = 0;
    pipeCount = 0;
    var res = await AssignFixDao.getQueryFinishAnalyse(date: selectDate);
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data;
        for(var dic in dataArray) {
          if (dic["SubTotal"] != null && dic["SubTotal"] != "") {
            totalCount = totalCount + int.parse(dic["SubTotal"]);
          }
          if (dic["Month"] != null && dic["Month"] != "") {
            mCount = mCount + int.parse(dic["Month"]);
          }
          if (dic["Today"] != null && dic["Today"] != "") {
            dCount = dCount + int.parse(dic["Today"]);
          }
          if (dic["Minus"] != null && dic["Minus"] != "") {
            minusCount = minusCount + int.parse(dic["Minus"]);
          }
          if (dic["Bigbad"] != null && dic["Bigbad"] != "") {
            bigBadCount = bigBadCount + int.parse(dic["Bigbad"]);
          }
          if (dic["Pipe"] != null && dic["Pipe"] != "") {
            pipeCount = pipeCount + int.parse(dic["Pipe"]);
          }
        }
      });
    }
    if (dataArray != null && dataArray != []) {
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
  ///高分隔線-red
  _buildLineHeightRed() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.red,
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

  ///取得裝置width並切8份
  _deviceWidth8() {
    var width = MediaQuery.of(context).size.width;
    return width / 8;
  }

  ///取得裝置width並切8份*2
  _deviceWidth82() {
    var width = MediaQuery.of(context).size.width;
    return (width / 8) * 2;
  }
  ///取得裝置width並切8份*3
  _deviceWidth83() {
    var width = MediaQuery.of(context).size.width;
    return (width / 8) * 3;
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
    var fontSize = MyScreen.analyzeListFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  /// title
  Widget _buildTitle() {
    return Container(
      height: _titleHeight() / 1.5,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth82() - 1,

          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_addTotal, TextStyle(color: Colors.black,)),
          ),
          _buildLineHeightRed(),
          Container(
            width: _deviceWidth83() - 1,
            child: _autoTextSize('SNR', TextStyle(color: Colors.black)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth82(),
            child: _autoTextSize(CommonUtils.getLocale(context).text_other, TextStyle(color: Colors.black,)),
          ),
        ],
      ),
    );
  }
   /// title2
  Widget _buildTitle2() {
    return Container(
      height: _titleHeight() / 1.5,
      color: isToday ? Color(MyColors.hexFromStr('#fafff2')) : Color(MyColors.hexFromStr('#f2f2f2')),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth82() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_people, TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_total, TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          _buildLineHeightRed(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_thisMonth, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_thisDay, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_minus, TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_bigbad, TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8(),
            child: _autoTextSize(CommonUtils.getLocale(context).text_pipe, TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  /// list item
  Widget _buildListItem(BuildContext context, int index) {
    var dic = dataArray[index];
    return GestureDetector(
      child: Container(
        height: _listHeight(),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.grey,
              style: BorderStyle.solid
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: _deviceWidth82() - 1,
              child: _autoTextSize(dic['EmpName'], TextStyle(color: Colors.black)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth8() - 1,
              child: _autoTextSize(dic['SubTotal'], TextStyle(color: Colors.black)),
            ),
            _buildLineHeightRed(),
            Container(
              width: _deviceWidth8() - 1,
              child: _autoTextSize(dic['Month'], TextStyle(color: Colors.black)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth8() - 1,
              child: _autoTextSize(dic['Today'], TextStyle(color: Colors.black)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth8() - 1,
              child: _autoTextSize(dic['Minus'], TextStyle(color: Colors.red)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth8() - 1,
              child: _autoTextSize('重大', TextStyle(color: Colors.green)),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth8(),
              child: _autoTextSize('區障', TextStyle(color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
      onTap: (){
        NavigatorUtils.goFinishedManDetail(context,empName: dic["EmpName"]);
      },
    );
  }
  /// list body 
  Widget _buildListBody() {
    Widget listBody;
    if (dataArray != null && dataArray.length > 0) {
      listBody = Expanded(
        child: ListView.builder(
          itemBuilder: _buildListItem,
          itemCount: dataArray.length,
        ),
      );
    }
    else {
      listBody = Container(child: buildEmpty());
    }
    return listBody;
  }
  /// bottom #f6e4d5
  Widget _bottomTitle() {
    return Container(
      height: _titleHeight() / 1.5,
      color: isToday ? Color(MyColors.hexFromStr('#f6e4d5')) : Color(MyColors.hexFromStr('#f2f2f2')),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth82() - 1,
            child: _autoTextSize('合計 ${dataArray.length} 人', TextStyle(color: Colors.black,)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize('$totalCount', TextStyle(color: Colors.black,)),
          ),
          _buildLineHeightRed(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize('$mCount', TextStyle(color: Colors.black, )),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize('$dCount', TextStyle(color: Colors.black, )),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize('$minusCount', TextStyle(color: Colors.red, )),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize('$bigBadCount', TextStyle(color: Colors.green, )),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8(),
            child: _autoTextSize('$pipeCount', TextStyle(color: Colors.blueAccent, )),
          ),
        ],
      ),
    );
  }
  /// widget body
  Widget getBody() {
    if(isLoading) {
      return showProgressLoading();
    }
    else {
      return Column(
        children: <Widget>[
          _buildTitle(),
          _buildLine(),
          _buildTitle2(),
          _buildLine(),
          _buildListBody(),
          _buildLine(),
          _bottomTitle(),
          _buildLine(),
          SizedBox(height: 10,)
        ],
      );
    }
  }
  ///日期選擇器
  showSelectorDateSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (context){
        var dialog = CupertinoActionSheet(
          title: Text('選擇日期'),
          cancelButton: CupertinoActionSheetAction(
            child: Text('取消'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: _selectorSort(),
        );
        return dialog;
      }
    );
  }
  ///alert 選項內容
  _selectorSort() {
    List<Widget> wList = [];
    for (var i=0; i< 7; i++) {
      var time = new DateTime(nowTime.year, nowTime.month, nowTime.day - i);
      var formatD = formatDate(time, [yyyy,'-',mm,'/',dd]);
      if (i == 0){
        formatD = '今日';
      }
      wList.add(
        CupertinoActionSheetAction(
          child: Text(formatD),
          onPressed: (){
            setState(() {
             if (i == 0) {
               formatD = formatDate(time, [yyyy,'-',mm,'/',dd]);
               isToday = true;
             }
             else {
               isToday = false;
             }
             selectDate = formatD;
             isLoading = true;
             getApiDataList();
            });
            Navigator.pop(context);
          },
        )
      );
    }
    return wList;
  }
  
  @override
  void initState() {
    super.initState();
    isLoading = true;
    isToday = true;
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
                  Container(
                    child: Text(CommonUtils.getLocale(context).text_wkPoint, style: TextStyle(color: Colors.white, fontSize: MyScreen.normalPageFontSize(context))),
                  ),
                  SizedBox(),
                  Container(
                    child: Text(CommonUtils.getLocale(context).text_snrPoint, style: TextStyle(color: Colors.yellow,fontSize: MyScreen.normalPageFontSize(context))),
                  ),
                  SizedBox(),
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: selectDate + '▼',
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.normalPageFontSize(context),
                      onPress: () {
                        showSelectorDateSheetController(context);
                      },
                    ),
                  ),
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
                  text: '',
                  textColor: Colors.yellow,
                  color: Colors.transparent,
                  fontSize: MyScreen.homePageFontSize(context),
                  onPress: () {},
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
                )
              ),
              ButtonTheme(
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: '',
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