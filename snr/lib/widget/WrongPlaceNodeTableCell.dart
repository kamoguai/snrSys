

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/model/WrongPlaceNodeTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * 自移統計列表
 * Date: 2019-04-28
 */
class WrongPlaceNodeTableItem extends StatelessWidget {
  final WrongPlaceNodeViewModel defaultViewModel;
  final int dataCount;
  WrongPlaceNodeTableItem({this.defaultViewModel,this.dataCount});

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
  _buildLineHeight(context) {
    return new Container(
      height: _titleHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線
  _buildLineHeightDouble(context) {
    return new Container(
      height: _titleHeight(context) * 2,
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切10份
  _deviceWidth10(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 10;
  }

  ///取得裝置height切4分
  _deviceHeight4(context) {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  _listHeight(context) {
    var height = _deviceHeight4(context);
    return height / 5;
  }

  ///title height
  _titleHeight(context) {
    var height = _deviceHeight4(context);
    return height / 4;
  }

   Widget _autoTextSize(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  Widget _container({child, width, height, color}) {

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0,style: BorderStyle.solid,color: Colors.grey)
        )
      ),
      height: height == null ? 25.0 : height,
      width: width,
      color: color,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _container(
      height: _listHeight(context),
      child: Row(
        children: <Widget>[
          Container(
            width: (_deviceWidth10(context) * 4) - 1,
            child: _autoTextSize(defaultViewModel.nodePath, TextStyle(color: Colors.black), context),
          ),
          _buildLineHeight(context),
          Container(
            width: (_deviceWidth10(context) * 3) - 1,
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth10(context) * 2) - 1,
                  child: _autoTextSize(defaultViewModel.bossLC, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth10(context) - 1,
                  child: _autoTextSize(defaultViewModel.bossCount, TextStyle(color: Colors.blue), context),
                )
              ],
            ),
          ),
          _buildLineHeight(context),
          Container(
            width: (_deviceWidth10(context) * 3) - 1,
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth10(context) * 2) - 1,
                  child: _autoTextSize(defaultViewModel.realLC, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth10(context) - 1,
                  child: _autoTextSize(defaultViewModel.realCount, TextStyle(color: Colors.brown), context),
                )
              ],
            ),
          )
        ],
      ),
    );  
  }
}

class WrongPlaceNodeViewModel {
  

  WrongPlaceNodeViewModel();

  String nodePath;//node路徑

  String node;//node

  String bossLC;//boss光點

  String bossCount;//boss數量

  String realLC;//實際光點

  String realCount;//實際數量

  WrongPlaceNodeViewModel.forMap(WrongPlaceNodeTableCell data) {
    nodePath = data.NodePath == null ? "" : data.NodePath;
    node = data.Node == null ? "" : data.Node;
    bossLC = data.BossLC == null ? "" : data.BossLC;
    bossCount = data.BossCount == null ? "" : data.BossCount;
    realLC = data.RealLC == null ? "" : data.RealLC;
    realCount = data.RealCount == null ? "" : data.RealCount;
  }
}