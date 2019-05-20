

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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
       setState(() {
        isLoading = false;
      });
    }
    else {
       setState(() {
        isLoading = false;
      });
    }
  }

  ///自動字大小
  @override
  Widget autoTextSize(text, style) {
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
      height: titleHeight() / 1.2,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth82() - 1,

          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_addTotal, TextStyle(color: Colors.black,)),
          ),
          buildRedLineHeight(),
          Container(
            width: deviceWidth83() - 1,
            child: autoTextSize('SNR', TextStyle(color: Colors.black)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth82(),
            child: autoTextSize(CommonUtils.getLocale(context).text_other, TextStyle(color: Colors.black,)),
          ),
        ],
      ),
    );
  }
   /// title2
  Widget _buildTitle2() {
    return Container(
      height: titleHeight() / 1.2,
      color: isToday ? Color(MyColors.hexFromStr('#fafff2')) : Color(MyColors.hexFromStr('#f2f2f2')),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth82() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_people, TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_total, TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          ),
          buildRedLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_thisMonth, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_thisDay, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_minus, TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize(CommonUtils.getLocale(context).home_btn_bigbad, TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8(),
            child: autoTextSize(CommonUtils.getLocale(context).text_pipe, TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
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
        height: titleHeight(),
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
              width: deviceWidth82() - 1,
              child: autoTextSize(dic['EmpName'], TextStyle(color: Colors.black)),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth8() - 1,
              child: autoTextSize(dic['SubTotal'], TextStyle(color: Colors.black)),
            ),
            buildRedLineHeight(),
            Container(
              width: deviceWidth8() - 1,
              child: autoTextSize(dic['Month'], TextStyle(color: Colors.black)),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth8() - 1,
              child: autoTextSize(dic['Today'], TextStyle(color: Colors.black)),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth8() - 1,
              child: autoTextSize(dic['Minus'], TextStyle(color: Colors.red)),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth8() - 1,
              child: autoTextSize('', TextStyle(color: Colors.green)),
            ),
            buildLineHeight(),
            Container(
              width: deviceWidth8(),
              child: autoTextSize('', TextStyle(color: Colors.blueAccent)),
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
      height: titleHeight() / 1.2,
      color: isToday ? Color(MyColors.hexFromStr('#f6e4d5')) : Color(MyColors.hexFromStr('#f2f2f2')),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth82() - 1,
            child: autoTextSize('合計 ${dataArray.length} 人', TextStyle(color: Colors.black,)),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize('$totalCount', TextStyle(color: Colors.black,)),
          ),
          buildRedLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize('$mCount', TextStyle(color: Colors.black, )),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize('$dCount', TextStyle(color: Colors.black, )),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize('$minusCount', TextStyle(color: Colors.red, )),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8() - 1,
            child: autoTextSize('$bigBadCount', TextStyle(color: Colors.green, )),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth8(),
            child: autoTextSize('$pipeCount', TextStyle(color: Colors.blueAccent, )),
          ),
        ],
      ),
    );
  }
  /// widget body
  Widget getBody() {
    if(isLoading) {
      return showLoadingAnime(context);
    }
    else {
      return Column(
        children: <Widget>[
          _buildTitle(),
          buildLine(),
          _buildTitle2(),
          buildLine(),
          _buildListBody(),
          buildLine(),
          _bottomTitle(),
          buildLine(),
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
          title: Text('選擇日期', style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
          cancelButton: CupertinoActionSheetAction(
            child: Text('取消', style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
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
          child: Text(formatD, style: TextStyle(fontSize: ScreenUtil().setSp(20)),),
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
             Future.delayed(const Duration(seconds: 1),(){
               getApiDataList();
             });
             
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
    Future.delayed(const Duration(seconds: 1),() {
      getApiDataList();
    });
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get isRefreshFirst => false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
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
                    setState(() {
                      isLoading = true;
                      Future.delayed(const Duration(seconds: 1),(){
                        getApiDataList();
                      });
                    });
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
              Container(
                height: 30,
                child: FlatButton.icon(
                  icon: Image.asset('static/images/23.png'),
                  color: Colors.transparent,
                  label: Text(''),
                  onPressed: (){

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