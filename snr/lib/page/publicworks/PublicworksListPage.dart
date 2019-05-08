import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/dao/PublicworksDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';

class PublicworksListPage extends StatefulWidget {
  @override
  _PublicworksListPageState createState() => _PublicworksListPageState();
}

class _PublicworksListPageState extends State<PublicworksListPage>
    with
        AutomaticKeepAliveClientMixin<PublicworksListPage>,
        MyListState<PublicworksListPage> {
  ///data 相關
  List<dynamic> dataArray = new List();
  List<dynamic> dataArray2 = new List();
  var instCount = 0;
  var maintainCount = 0;
  var instFixCount = 0;
  var fixfixCount = 0;
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
    var res = await PublicworksDao.getQueryOverTimeAnalyse();
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data["Data"];
        for (var dic in dataArray) {
          if (dic["INST"] != null && dic["INST"] != "") {
            instCount = instCount + int.parse(dic["INST"]);
          }
          if (dic["MAINTAIN"] != null && dic["MAINTAIN"] != "") {
            maintainCount = maintainCount + int.parse(dic["MAINTAIN"]);
          }
          if (dic["INSTFIX"] != null && dic["INSTFIX"] != "") {
            instFixCount = instFixCount + int.parse(dic["INSTFIX"]);
          }
          if (dic["FIXFIX"] != null && dic["FIXFIX"] != "") {
            fixfixCount = fixfixCount + int.parse(dic["FIXFIX"]);
          }
        }
        isLoading = false;
      });
    }
    else {
       setState(() {
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

  ///高分隔線
  _buildLineHeight() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線red
  _buildLineHeightRed() {
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

  Widget _buildWorkTitle1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fef5f6')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth6() * 2) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_status, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_inst, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_maintain, Colors.black),
          ),
          _buildLineHeightRed(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_instFix, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_fixfix, Colors.pink),
          ),
        ],
      ),
    );
  }

  ///publicList1
  Widget _buildWorkListItem1(BuildContext contex, int index) {
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
              width: (_deviceWidth6() * 2) - 1,
              child: _autoTextSize(dic["Area"] ?? "", Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["INST"] ?? "", Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["MAINTAIN"] ?? "", Colors.black),
            ),
            _buildLineHeightRed(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(dic["INSTFIX"] ?? "", Colors.red),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["FIXFIX"] ?? "", Colors.pink),
            ),
          ],
        ),
      ),
      onTap: () {
        NavigatorUtils.goPublicworksDetail(context);
      },
    );
  }

  ///public list
  Widget _buildWorkList1() {
    Widget publicList;
    if (dataArray.length > 0) {
      publicList = Container(
        height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildWorkListItem1,
          itemCount: dataArray.length,
        ),
      );
    } else {
      publicList = Container(child: buildEmpty());
    }
    return publicList;
  }

  ///work bottom
  Widget _buildWorkBottom1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth6() * 2) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_total, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(instCount == 0 ? "" : instCount, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                maintainCount == 0 ? "" : maintainCount, Colors.black),
          ),
          _buildLineHeightRed(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                instFixCount == 0 ? "" : instFixCount, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child:
                _autoTextSize(fixfixCount == 0 ? "" : fixfixCount, Colors.pink),
          ),
        ],
      ),
    );
  }

  ///work head title2
  Widget _buildWorkTitle2() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fef5f6')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth6() * 2) - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_people, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_inst, Colors.black),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_maintain, Colors.black),
          ),
          _buildLineHeightRed(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_instFix, Colors.red),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(
                CommonUtils.getLocale(context).text_fixfix, Colors.pink),
          ),
        ],
      ),
    );
  }

  ///list 2
  Widget _buildWorkListItem2(BuildContext context, int index) {
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
              width: (_deviceWidth6() * 2) - 1,
              child: _autoTextSize(
                  CommonUtils.getLocale(context).text_status, Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(
                  CommonUtils.getLocale(context).text_inst, Colors.black),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(
                  CommonUtils.getLocale(context).text_maintain, Colors.black),
            ),
            _buildLineHeightRed(),
            Container(
              width: _deviceWidth6() - 1,
              child: _autoTextSize(
                  CommonUtils.getLocale(context).text_instFix, Colors.red),
            ),
            _buildLineHeight(),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(
                  CommonUtils.getLocale(context).text_fixfix, Colors.pink),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  /// public list2
  Widget _buildWorkList2() {
    Widget publicList2;
    if (dataArray2 != null && dataArray2.length > 0) {
      publicList2 = Container(
        height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildWorkListItem2,
          itemCount: dataArray2.length,
        ),
      );
    } else {
      publicList2 = Container(
        child: buildEmpty(),
      );
    }
    return publicList2;
  }

  ///將body寫在這裡
  Widget getBody() {
    return isLoading
        ? showProgressLoading()
        : new Column(
            children: <Widget>[
              ///headtilte
              _buildWorkTitle1(),
              _buildLine(),
              _buildWorkList1(),
              // _buildLine(),
              _buildWorkBottom1(),
              _buildLine(),
              SizedBox(
                height: 10.0,
              ),
              _buildLine(),
              _buildWorkTitle2(),
              _buildLine(),
              _buildWorkList2(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        text: CommonUtils.getLocale(context).text_ww,
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                    
                        },
                      ),
                    ),
                    // SizedBox(),
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
                    SizedBox(),
                    Text('',
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context),
                            color: Colors.white)
                    ),
                    SizedBox(),
                    SizedBox(),
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
