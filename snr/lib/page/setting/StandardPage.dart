
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
/**
 * 設定-標準頁面
 * Date: 2019-05-07
 */
class StandardPage extends StatelessWidget {

  ///分隔線
  buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///分隔線red
  buildLineRed() {
    return new Container(
      height: 1.0,
      color: Colors.red,
    );
  }

  ///高分隔線
  buildLineHeight(context) {
    return new Container(
      height: listHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切2份
  deviceWidth2(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 2;
  }

  ///取得裝置width並切3份
  deviceWidth3(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 3;
  }


  ///取得裝置width並切4份
  deviceWidth4(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 4;
  }

  ///取得裝置width並切5份
  deviceWidth5(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 5;
  }

  ///取得裝置width並切6份
  deviceWidth6(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }

  ///取得裝置height切4分
  deviceHeight4(context) {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  listHeight(context) {
    var height = deviceHeight4(context);
    return height / 5;
  }

  ///title height
  titleHeight(context) {
    var height = deviceHeight4(context);
    return height / 4;
  }
  ///自動字大小
  _autoTextSize(text, style, BuildContext context) {
    var fontSize = MyScreen.normalListPageFontSize_s(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
    ///自動字大小s
  _autoTextSize_s(text, style, BuildContext context) {
    var fontSize = MyScreen.defaultTableCellFontSize_s(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  ///container
  _container({child, height, width, color}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration( color: color,border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
      width: width,
      child: child,
      height: height,
    );
  }
  ///app bar actions
  _renderAppBarAction(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: deviceWidth3(context),
            child: Text(CommonUtils.getLocale(context).text_standar, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: MyScreen.appBarFontSize(context)),),
          ),
          Container(
            alignment: Alignment.center,
            width: deviceWidth3(context),
            child: FlatButton.icon(
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
                    fontSize: MyScreen.normalPageFontSize_s(context)),
              ),
              onPressed: () {
                print(123);
              },
            )
          ),
          Container(
            width: deviceWidth3(context),
            child: MyToolButton(
              text: '',
              textColor: Colors.white,
              fontSize: MyScreen.appBarFontSize(context),
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              onPress: (){
              
              },
            ),
          ),
        ],
      ),
    );
  }
  ///bottomNavBar item
  _renderBottomItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: CommonUtils.getLocale(context).common_toolBar_set,
            textColor: Colors.white,
            color: Colors.transparent,
            fontSize: MyScreen.homePageFontSize(context),
            onPress: () {
              
            },
          ),
        ),
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: CommonUtils.getLocale(context).text_standar,
            textColor: Colors.white,
            color: Colors.transparent,
            fontSize: MyScreen.homePageFontSize(context),
            onPress: () {
              
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
                fontSize: MyScreen.homePageFontSize(context)),
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
            fontSize: MyScreen.homePageFontSize(context),
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
            fontSize: MyScreen.homePageFontSize(context),
            mainAxisAlignment: MainAxisAlignment.start,
            onPress: () {
              print('it click');
              Navigator.pop(context);          
            },
          ),
        ),
      ],
    );
  }
  ///body
  _renderBody(BuildContext context) {
    Widget body;
    body = Column(
      children: <Widget>[
        _container(child: _autoTextSize('SNR標準', TextStyle(color: Colors.black, fontWeight: FontWeight.bold),context), height: listHeight(context)),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: _autoTextSize('上行', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                child: _autoTextSize('下行', TextStyle(color: Colors.black), context),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: _autoTextSize('CH=4', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                child: _autoTextSize('CH=8', TextStyle(color: Colors.black), context),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: _autoTextSize('SNR>32', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                child: _autoTextSize('SNR>33', TextStyle(color: Colors.black), context),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: _autoTextSize('POW<42~48', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                child: _autoTextSize('POW<-10~15', TextStyle(color: Colors.black), context),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: _autoTextSize('BER<10e~10e', TextStyle(color: Colors.black,fontWeight: FontWeight.bold), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                child: _autoTextSize('MER>33~39', TextStyle(color: Colors.black,fontWeight: FontWeight.bold), context),
              ),
            ],
          )
        ),
        _container(height: listHeight(context)),
        _container(child: _autoTextSize('SNR監控標準', TextStyle(color: Colors.black, fontWeight: FontWeight.bold),context), height: listHeight(context)),
        _container(child: _autoTextSize('外網-上行 CH=4', TextStyle(color: Colors.black, fontWeight: FontWeight.bold),context), height: listHeight(context)),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('1.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('2.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('3.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('4.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        _container(child: _autoTextSize('內網-上行 CH=4', TextStyle(color: Colors.black, fontWeight: FontWeight.bold),context), height: listHeight(context)),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('1.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('2.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('3.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize('4.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('47', TextStyle(color: Colors.blue), context),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        _container(child: _autoTextSize('內網-下行 CH=8', TextStyle(color: Colors.black, fontWeight: FontWeight.bold),context), height: listHeight(context)),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('外網MER>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('-5', TextStyle(color: Colors.red), context),
                    ),
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: deviceWidth2(context),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('內網MER>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('30', TextStyle(color: Colors.blue), context),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      child: _autoTextSize('-5', TextStyle(color: Colors.red), context),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        _container(
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: _autoTextSize('設定日期', TextStyle(color: Colors.grey), context),
              ),
              buildLineHeight(context),
              Container(
                width:  deviceWidth2(context),
                child: _autoTextSize('設定人', TextStyle(color: Colors.grey), context),
              )
            ],
          )
        )
      ],
    );
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          body
        ],
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
          leading: Container(),
          elevation: 0.0,
          actions: <Widget>[
            _renderAppBarAction(context)
          ],
        ),
        body: _renderBody(context),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor, //底部导航栏主题颜色
          child: _renderBottomItem(context)
        ),
      ),
    );
  }
}