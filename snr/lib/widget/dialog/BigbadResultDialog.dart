

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/helper/ensure_visible.dart';

/**
 * 重大查修結果回報dialog
 * Date: 2019-04-25
 */
class BigBadResultDialog extends StatelessWidget {

  final int dataCount;
  final _focusNode = FocusNode();
  BigBadResultDialog(this.dataCount);

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  _deviceWidth3(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return (deviceWidth / 3) - 1;
  }

  _deviceWidth6(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return (deviceWidth / 6) - 1;
  }

  ///取得裝置height切4分
  _deviceHeight4(BuildContext context) {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  _listHeight(BuildContext context) {
    var height = _deviceHeight4(context);
    return height / 7;
  }

  ///title height
  _titleHeight(BuildContext context) {
    var height = _deviceHeight4(context);
    return height / 4.8;
  }
  
  ///字體自動縮放
  _autoTextSize(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  
  ///查修人員item
  Widget _checkManItem(BuildContext context, int index){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey, width: 1.0, style: BorderStyle.solid
          )
        )
      ),
      width: _deviceWidth6(context),
      height: _listHeight(context),
      child: _autoTextSize('查修人', TextStyle(color: Colors.black),context),
    );
  }
  ///查修人員list
  Widget _checkManList(context){
    Widget list;
    if(dataCount > 0) {
      list = Container(
        height: _listHeight(context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: _checkManItem,
          itemCount: dataCount,
        ),
      );
    }
    else {
      list = Container(height: _listHeight(context),);
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    Widget build;

    build = Container(
      color: Color(MyColors.hexFromStr('#fff7f6')),
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: _titleHeight(context),
            child: _autoTextSize('查修結果回報', TextStyle(color: Colors.black), context),
          ),
          _buildLine(),
          Container(
            child: EnsureVisibleWhenFocused(
              focusNode: _focusNode,
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5.0),
                ),
                // controller: TextEditingController(),
                enabled: true,
                onChanged: (String value) {
                  print(value);
                },
              ),
            ),
          ),
          _buildLine(),
           Container(
            height: _listHeight(context),
            child: _autoTextSize('查修人', TextStyle(color: Colors.black), context),
          ),
          _buildLine(),
          _checkManList(context),
          _buildLine(),
          Container(
            height: _titleHeight(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border(right: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  width: _deviceWidth3(context) - 2,
                  height: _listHeight(context),
                  child: FlatButton(
                    textColor: Colors.green,
                    child: _autoTextSize('修改', TextStyle(color: Colors.green, fontWeight: FontWeight.bold), context),
                    onPressed: (){

                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border(right: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  width: _deviceWidth3(context) - 2,
                  height: _listHeight(context),
                  child: FlatButton(
                    textColor: Colors.green,
                    child: _autoTextSize('確定', TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), context),
                    onPressed: (){

                    },
                  ),
                ),
                Container(
                  width: _deviceWidth3(context) - 2,
                  height: _listHeight(context),
                  child: FlatButton(
                    textColor: Colors.green,
                    child: _autoTextSize('離開', TextStyle(color: Colors.red, fontWeight: FontWeight.bold), context),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );


    return build;
  }
}