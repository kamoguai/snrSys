
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/dialog/BigbadHistoryDialog.dart';
import 'package:snr/widget/dialog/BigbadResultDialog.dart';

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
  ///是否顯示收按按鈕
  var isShowAccept = false;
 
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
  Widget _autoTextSize(text, color, {fontWeight}) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
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
              padding: EdgeInsets.only(left: 5.0),
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
  ///reportMan item
  Widget _buildReportManItem(BuildContext context, int index) {
    Widget item;
    item = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, width: 1.0, style: BorderStyle.solid)
          )
        ),
      height: _listHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth6() * 1.5) - 1,
            child: ListView(
              padding: EdgeInsets.only(left: 5.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _autoTextSize('time and man time and man', Colors.blueAccent),
              ],
            )
          ),
          _buildLineHeight(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 5.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                 _autoTextSizeLeft('memo view,memo view,memo view,memo view,memo view,memo view,memo view,memo view,memo view,', Colors.black)
              ],
            )
            
          )
          // ListView(
          //   scrollDirection: Axis.horizontal,
          //   children: <Widget>[
          //     Expanded(
          //       child: _autoTextSizeLeft('memo view,', Colors.black),
          //     )
          //   ],
          // ),
          
        ],
      ),
    );
    return item;
  }
  ///reportMan list
  Widget _buildReportManList() {
    Widget list;
    // if (dataArray.length > 0) {
      list = Container(
        height: _listHeight() * 3,
        child: ListView.builder(
          itemBuilder: _buildReportManItem,
          itemCount: dataArray.length + 2,
        ),
      );
    // }
    // else {
    //   list = Container(height: _listHeight() * 3,);
    // }
    return list;
  }
  ///發報時間
  Widget _buildHQTime() {
    Widget hq;
    hq = Container(
      height: _listHeight(),
      color: Color(MyColors.hexFromStr('#f2f2f2')),
      child: ListView(
        padding: EdgeInsets.only(left: 5.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _autoTextSize('發報時間:', Colors.black, fontWeight: FontWeight.bold),
              _autoTextSize('開始時間', Colors.red,),
              _autoTextSize('~', Colors.black,),
              _autoTextSize('結束時間', Colors.blueAccent,),
              SizedBox(width: 10.0,),
              _autoTextSize('(耗時:h:mm)', Colors.black,),
            ],
          ),
        ],
      )
    );
    return hq;
  }
  ///查修人員 item
  Widget _buildCheckManItem(BuildContext context, int index) {
    Widget item;
    item = Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey, width: 1.0, style: BorderStyle.solid
          )
        )
      ),
      width: _deviceWidth6(),
      height: _listHeight(),
      child: _autoTextSize('查修人', Colors.black),
    );
    return item;
  }
  /// 查修人員list
  Widget _buildCheckManList() {
    Widget list;
    // if(dataArray.length > 0) {
      list = GestureDetector(
        child: Container(
          height: _listHeight(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: _buildCheckManItem,
            itemCount: dataArray.length + 10,
          ),
        ),
        onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildMantoFinishedDialog(context)
          );
        },
      );
      
      
    // }
    // else {
    //   list = Container(height: _listHeight(),);
    // }
    return list;
  }
  ///查修結果
  Widget _buildCheckResult() {
    Widget result;
    result = GestureDetector(
      child: Container(
        height: _listHeight() * 2.5,
        color: Color(MyColors.hexFromStr('#fff7f6')),
        child: ListView(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _autoTextSizeLeft('查修結果: 此番修正問題結果如何，此番修正問題結果如何，此番修正問題結果如何，此番修正問題結果如何，此番修正問題結果如何，此番修正問題結果如何，此番修正問題結果如何，', Colors.grey),
          ],
        ),
      ),
      onTap: (){
        showDialog(
          context: context,
          builder: (BuildContext context) => checkReportDialog(context)
        );
      },
    );
    return result;
  }
  ///歷史title
  Widget _buildHistoryTitle() {
    Widget title;
    title = Container(
      color: Color(MyColors.hexFromStr('#f0fcff')),
      height: _listHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _autoTextSize('過去查修歷史', Colors.black, fontWeight: FontWeight.bold),
        ],
      ),
    );
    return title;
  }
  ///歷史item
  Widget _buildHistoryItem(BuildContext context, int index) {
    Widget item;
    var value = index % 2;

    item = Container(
      color: value > 0 ? Color(MyColors.hexFromStr('#f2f2f2')) : Colors.white ,
      height: _listHeight() * 2,
      child: Column(
        children: <Widget>[
          Container(
            height: _listHeight() - 1,
            child: ListView(
              padding: EdgeInsets.only(left: 5.0,),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _autoTextSizeLeft('日期/ 開始時間~結束時間 (耗時) 人員a,人員b', Colors.grey),
              ],
            )
          ),
          _buildLine(),
          Container(
            height: _listHeight() - 1,
            child: ListView(
              padding: EdgeInsets.only(left: 5.0,),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _autoTextSizeLeft('查修結果', Colors.grey),
              ],
            )
          ),
          _buildLine(),
        ],
      ),
    );
    return item;
  }
  ///歷史list
  Widget _buildHistoryList() {
    Widget list;
    // if(dataArray.length > 0) {
      list = GestureDetector(
        child: Container(
          height: _listHeight() * 6,
          child: ListView.builder(
            itemBuilder: _buildHistoryItem,
            itemCount: dataArray.length + 4,
          ),
        ),
        onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildHistoryDialog(context)
          );
        },
      );
      
    // }
    // else {
    //   list = Expanded(child: Container(),);
    // }
    return list;
  }
  ///將body寫在這裡
  Widget getBody() {
    Widget body;
    if (isLoading) {
      body = showLoadingAnime(context);
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
            _buildReportManList(),
            _buildLine(),
            _buildHQTime(),
            _buildLine(),
            _buildCheckManList(),
            _buildLine(),
            _buildCheckResult(),
            _buildLine(),
            _buildHistoryTitle(),
            _buildLine(),
            _buildHistoryList()
          ],
        ),
      );
    }
    return body;
  }
  ///查修回報dialog
  Widget checkReportDialog(BuildContext context) {
    return GestureDetector(
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: BigBadResultDialog(3),
            )
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }
  ///人員至完工記點
  Widget _buildMantoFinished() {
    Widget dialog;
    dialog = Container(
      width: double.maxFinite,
      height: _titleHeight() * 2,
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: _titleHeight(),
            child: _autoTextSize("是否要將本案轉至完工記點", Colors.black),
          ),
          _buildLine(),
          _buildCheckManList(),
          _buildLine(),
        ],
      ),
    );
    return dialog;
  }
  ///人員至完工記點dialog
  Widget _buildMantoFinishedDialog(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            child: _buildMantoFinished(),
          ),
          SizedBox(height: 20.0,),
          Card(
            child: Container(
              height: _titleHeight() * 1.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    // width: _deviceWidth2() - 3,
                    child: FlatButton(
                      child: Text('確定', style: TextStyle(color: Colors.blueAccent)),
                      onPressed: (){

                      },
                    ),
                  ),
                  _buildLineHeight(),
                  Container(
                    // width: _deviceWidth2() - 3,
                    child: FlatButton(
                      child: Text('離開', style: TextStyle(color: Colors.red)),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  ///歷史dialog
  Widget _buildHistoryDialog(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Card(
        child: BigBadHistoryDialog(),
      ),
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
                      text: '全國',
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.normalPageFontSize(context),
                      onPress: () {
                       setState(() {
                         isShowAccept = true;
                       });
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
        floatingActionButton: isShowAccept ?  FloatingActionButton(
          backgroundColor: Colors.red,
          child: Text('收案'),
          onPressed: (){
            Fluttertoast.showToast(msg: '收取案件！');
          },
        ) : null,
      )
    );
  }
}