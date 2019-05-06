

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snr/common/style/MyStyle.dart';

class ParamSettingPage extends StatefulWidget {
  @override
  _ParamSettingPageState createState() => _ParamSettingPageState();
}

class _ParamSettingPageState extends State<ParamSettingPage> with AutomaticKeepAliveClientMixin<ParamSettingPage>{


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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('1.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('2.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('3.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('4.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('1.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('2.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('3.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('4.SNR>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('外網MER>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: _autoTextSize_s('內網MER>', TextStyle(color: Colors.black), context),
                    ),
                    Container(
                      width: 30.0,
                      child: TextField(
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
                        // keyboardType: TextInputType.numberWithOptions(),
                        style: TextStyle(fontSize: 12, color: Colors.blue),
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
      ],
    );
    return body;
  }

  // @override
  // bool get isRefreshFirst => false;

  @override
  void initState() {
    super.initState();
    // isLoading = true;

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
    return getBody();
  }
}