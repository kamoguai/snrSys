
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
 * 重大異常詳情頁面
 * Date: 2019-04-24
 */
class BigBadDetailPage extends StatefulWidget {
  @override
  _BigBadDetailPageState createState() => _BigBadDetailPageState();
}

class _BigBadDetailPageState extends State<BigBadDetailPage> with AutomaticKeepAliveClientMixin<BigBadDetailPage>, MyListState<BigBadDetailPage> {

  ///data 相關
  List<dynamic> dataArray = new List();
 
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
    isLoading = false;
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
    return height / 7;
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
  ///cmts
  Widget _buildCmts() {
    Widget cmts;
    cmts = Container(
      height: _listHeight() * 2,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5.0),
            height: _listHeight() - 1,
            child: _autoTextSizeLeft('地址地址', Colors.grey),
          ),
          _buildLine(),
          Container(
            padding: EdgeInsets.only(left: 5.0),
            height:  _listHeight() - 1,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _autoTextSizeLeft('cmts', Colors.black),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),          
                    // padding: EdgeInsets.all(2.0),
                    child: Image.asset('static/images/pingBtn.png',),
                  ),
                  onTap: (){print(134);},
                ),
              ],
            ),
          )
        ],
      ),
    );
    return cmts;
  }
  ///total
  Widget _buildTotalTitle() {
    Widget title;
    title = Container(
      height: _listHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_online, Colors.blue),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_upP, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_problem, Colors.pink),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_assignFix, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_percent, Colors.blueAccent),
          ),
        ],
      ),
    );
    return title;
  }
  ///totalItem
  Widget _buildTotalItem(BuildContext context, int index) {
    Widget totalItem;
    totalItem = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, width: 1.0, style: BorderStyle.solid))),
      height: _listHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_online, Colors.blue),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_upP, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_problem, Colors.pink),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_assignFix, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_percent, Colors.blueAccent),
          ),
        ],
      ),
    );
    return totalItem;
  }
  /// totalItem listview
  Widget _buildTotalList(){
    Widget totalList;
    // if (dataArray.length > 0) {
      totalList = Container(
        height: (_listHeight() * 2),
        child: ListView.builder(
          itemBuilder: _buildTotalItem,
          itemCount: dataArray.length + 2,
        ),
      );
    // }
    // else {
    //   totalList = Container(height: (_listHeight() * 2));
    // }
    return totalList;
  }
  ///光點title
  Widget _buildLightTitle() {
    Widget lightTitle;
    lightTitle = Container(
      color: Color(MyColors.hexFromStr('#f0fcff')),
      height: _listHeight() * 2,
      child: Column(
        children: <Widget>[
          Container(
            height: _listHeight() - 1,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _autoTextSize(CommonUtils.getLocale(context).text_affectLight, Colors.black),
              ],
            ),
          ),
          _buildLine(),
          Container(
            height: _listHeight(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _autoTextSize('text', Colors.black)
              ],
            ),
          )
        ],
      )
    );
    return lightTitle;
  }
  ///人員
  Widget _buildMans() {
    Widget mans;
    mans = Container(
      color: Color(MyColors.hexFromStr('#fafff2')),
      height: _listHeight() * 2,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            height: _listHeight() - 1,
            child: _autoTextSize('text', Colors.black),
          ),
          _buildLine(),
          Container(
            alignment: Alignment.centerLeft,
            height: _listHeight(),
            child: _autoTextSize('text', Colors.black),
          ),
        ],
      ),
    );
    return mans;
  }
  ///將body寫在這裡
  Widget getBody() {
    Widget body;
    if (isLoading) {
      body = showProgressLoading();
    }
    else {
      body = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _buildCmts(),
            _buildLine(),
            _buildTotalTitle(),
            _buildLine(),
            _buildTotalList(),
            // _buildLine(),
            _buildLightTitle(),
            _buildLine(),
            _buildMans(),
            _buildLine(),
          ],
        ),
      );
    }
    return body;
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
                      text: '全國',
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
                      text: '',
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
                      text: '重大異常',
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
                      text: '',
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
                      text: '',
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.normalPageFontSize(context),
                      onPress: () {
                        
                      },
                    ),
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
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: CommonUtils.getLocale(context).text_register,
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: MyScreen.normalPageFontSize(context),
                  onPress: () {
                  
                  },
                ),
              ),
              ButtonTheme(
                 minWidth: MyScreen.homePageBarButtonWidth(context),
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
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  text: '',
                  textColor: Colors.white,
                  color: Colors.transparent,
                  fontSize: MyScreen.normalPageFontSize(context),
                  mainAxisAlignment: MainAxisAlignment.start,
                  onPress: () {
                  
                  },
                ),
              ),
              ButtonTheme(
                minWidth: MyScreen.homePageBarButtonWidth(context),
                child: new MyToolButton(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
      )
    );
  }
}