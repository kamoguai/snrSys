

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snr/common/style/MyStyle.dart';

class ParamSettingPage extends StatefulWidget {
  @override
  _ParamSettingPageState createState() => _ParamSettingPageState();
}

class _ParamSettingPageState extends State<ParamSettingPage> with AutomaticKeepAliveClientMixin<ParamSettingPage>{

  //是否能編輯
  var isEdit = false;

  getApiDataList(){

  }
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

  Widget getBody() {
    Widget body;
    body = Column(
      children: <Widget>[
        _container(child: _autoTextSize('SNR監控標準', TextStyle(color: Colors.black, fontWeight: FontWeight.bold),context), height: listHeight(context)),
        _container(child: _autoTextSize('外網-上行 CH=4', TextStyle(color: Colors.black, fontWeight: FontWeight.bold), context), color: Color(MyColors.hexFromStr('#ffffe4')), height: listHeight(context)),
        _container(
          color: Color(MyColors.hexFromStr('#ffffe4')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('1.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('2.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        _container(
          color: Color(MyColors.hexFromStr('#ffffe4')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('3.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('4.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        _container(child: _autoTextSize('內網-上行 CH=4', TextStyle(color: Colors.black, fontWeight: FontWeight.bold), context), color: Color(MyColors.hexFromStr('#f0fcff')), height: listHeight(context)),
        _container(
          color: Color(MyColors.hexFromStr('#f0fcff')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('1.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('2.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        _container(
          color: Color(MyColors.hexFromStr('#f0fcff')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('3.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('4.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．上P<', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        _container(child: _autoTextSize('內外網-下行 CH=8', TextStyle(color: Colors.black, fontWeight: FontWeight.bold), context), color: Color(MyColors.hexFromStr('#fafff2')), height: listHeight(context)),
        _container(
          color: Color(MyColors.hexFromStr('#fafff2')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('外網MER>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．下P>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('內網MER>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    ),
                    Container(
                      child: _autoTextSize_s('．下P>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        enabled: isEdit,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2.0),
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                        ),
                        onChanged: (String value) {
                          
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        _container(
          height: listHeight(context),
          color: Color(MyColors.hexFromStr('#f2f2f2')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: _autoTextSize('設定日期:', TextStyle(color: Colors.grey), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: _autoTextSize('設定人', TextStyle(color: Colors.grey), context),
              ),
            ],
          )
        ),
        Container(height: listHeight(context), decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)))),
        _container(
          height: listHeight(context),
          color: Color(MyColors.hexFromStr('#ffeef1')),
          child: _autoTextSize('上行Mhz(頻差6.4)', TextStyle(color: Colors.black), context)
        ),
        _container(
          height: listHeight(context),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: (deviceWidth6(context) * 2) - 1,
                child: _autoTextSize_s('上行第一段頻率', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) ,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
            ],
          )
        ),
        _container(
          height: listHeight(context),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: (deviceWidth6(context) * 2) - 1,
                child: _autoTextSize_s('上行第二段頻率', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
               child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) ,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
            ],
          )
        ),
        _container(
          height: listHeight(context),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                width: (deviceWidth6(context) * 2) - 1,
                child: _autoTextSize_s('上行第三段頻率', TextStyle(color: Colors.black), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) - 1,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth6(context) ,
                child: TextField(
                  enabled: isEdit,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: MyScreen.appBarFontSize(context), color: Colors.blue),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],                    
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.0),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0),borderSide: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))  
                  ),
                  onChanged: (String value) {
                    
                  },
                ),
              ),
            ],
          )
        ),
        _container(
          height: listHeight(context),
          color: Color(MyColors.hexFromStr('#f2f2f2')),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: _autoTextSize('設定日期:', TextStyle(color: Colors.grey), context),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: _autoTextSize('設定人', TextStyle(color: Colors.grey), context),
              ),
            ],
          )
        ),
        Container(height: listHeight(context), decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid)))),
        _container(
          height: titleHeight(context),
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth2(context) - 1,
                child: FlatButton(
                  child: _autoTextSize('修改', TextStyle(color: Colors.green), context),
                  onPressed: () {
                    setState(() {
                      isEdit = true;
                    });
                  },
                ),
              ),
              buildLineHeight(context),
              Container(
                width: deviceWidth2(context),
                child: FlatButton(
                  child: _autoTextSize('確定', TextStyle(color: Colors.blue), context),
                  onPressed: () {
                    setState(() {
                      isEdit = false;
                    });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
    return body;
  }

  @override
  void initState() {
    super.initState();

    getApiDataList();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            getBody()
          ],
        ),
      ),
    );
  }
}