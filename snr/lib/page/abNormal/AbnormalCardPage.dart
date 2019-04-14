import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';

/**
 * 卡板列表頁面
 * Date: 2019-03-28
 */
class AbnormalCardPage extends StatefulWidget {
  static final String sName = "abnormalCard";

  final String CMTSCode;
  final String Name;
  final String Time;

  AbnormalCardPage(this.CMTSCode, this.Name, this.Time, {Key key})
      : super(key: key);

  @override
  _AbnormalCardPageState createState() => _AbnormalCardPageState();
}

class _AbnormalCardPageState extends State<AbnormalCardPage> with AutomaticKeepAliveClientMixin<AbnormalCardPage>, MyListState<AbnormalCardPage> {
  ///data 相關
  List<dynamic> dataArray = new List();
  List<dynamic> dataArray2 = new List();

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

  ///取得api data
  getApiDataList() async {
    dataArray = [];
    dataArray2 = [];
    var res = await AbnormalDao.getSNRSignalByCMTS(widget.CMTSCode);
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data['Data'];
        dataArray2 = res.data['Data2'];
        // dataArray = res.data;
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

  ///取得裝置width並切6份
  _deviceWidth6() {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
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
    var fontSize = MyScreen.normalPageFontSize(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCmtsHeader1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#f5ffe9')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).abnormal_card_hub, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_online, Colors.blue),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_upP, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_problem, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_percent, Colors.pink),
          ),
        ],
      ),
    );
  }
  ///cmtsList1
  Widget _buildCmtsListItem1(BuildContext contex, int index) {
    var dic = dataArray[index];
    return GestureDetector(
      child: Container(
        height: _listHeight(),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid
          ))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["CIF"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["OnLine"], Colors.blue),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["OverPower"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["Problem"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["Bad"], Colors.red),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize('${((double.parse(dic['BadRate']) * 1000) / 10).toStringAsFixed(1)}%', Colors.blue),
            ),
          ],
        ),
      ),
      onTap: (){
        NavigatorUtils.goAbnormalNode(context, widget.CMTSCode, dic['CIF'], "${widget.Name} ${dic['CIF']}", widget.Time);
      },
    );
  }
  /// cmts list
  Widget _buildCmtsList1() {
    Widget cmtsList;
    if(dataArray.length > 0) {
      cmtsList = Container(
        height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildCmtsListItem1,
          itemCount: dataArray.length,
        ),
      );
    }
    else {
      cmtsList = Container(child: buildEmpty());
    }
    return cmtsList;
  }
///cmts head title2
Widget _buildCmtsHeader2() {
  return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).abnormal_card_text, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_online, Colors.blue),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_upP, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_problem, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_percent, Colors.pink),
          ),
        ],
      ),
    );
  }
  ///list 2
  Widget _buildCmtsListItem2(BuildContext context, int index) {
    var dic = dataArray2[index];
    return GestureDetector(
      child: Container(
        height: _listHeight(),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid
          ))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["CIF"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["OnLine"], Colors.blue),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["OverPower"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["Problem"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["Bad"], Colors.red),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize('${((double.parse(dic['BadRate']) * 1000) / 10).toStringAsFixed(1)}%', Colors.blue),
            ),
          ],
        ),
      ),
      onTap: (){

      },
    );
  }
   /// cmts list2
  Widget _buildCmtsList2() {
    Widget cmtsList2;
    if(dataArray2 != null && dataArray2.length > 0) {
      cmtsList2 = Container(
        height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildCmtsListItem2,
          itemCount: dataArray2.length,
        ),
      );
    }
    else {
      cmtsList2 = Container(child: buildEmpty(),);
    }
    return cmtsList2;
  }
  ///將body寫在這裡
  Widget getBody() {
    return isLoading
        ? showProgressLoading()
        : new Column(
            children: <Widget>[
              ///headtilte
              _buildCmtsHeader1(),
              _buildLine(),
              _buildCmtsList1(),
              _buildLine(),
              _buildCmtsHeader2(),
              _buildLine(),
              _buildCmtsList2(),
              // _buildLine(),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              new Expanded(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text(widget.Name,
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context))),
                    new Text('         ',
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context))),
                    new Text('資料:${widget.Time}',
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context)))
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
                  // minWidth: MyScreen.homePageBarButtonWidth(context),
                  child: new MyToolButton(
                    // padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                    // padding: EdgeInsets.all(1.0),
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
                    style:
                        TextStyle(fontSize: MyScreen.normalPageFontSize(context)),
                  ),
                  onPressed: () {
                    print(123);
                  },
                )),
                ButtonTheme(
                  // minWidth: MyScreen.homePageBarButtonWidth(context),
                  child: new MyToolButton(
                    // padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    padding: EdgeInsets.all(1.0),
                    text: CommonUtils.getLocale(context).text_back,
                    textColor: Colors.white,
                    color: Colors.transparent,
                    fontSize: MyScreen.normalPageFontSize(context),
                    mainAxisAlignment: MainAxisAlignment.start,
                    onPress: () {
                      if (isLoading) {
                        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
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
