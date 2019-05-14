

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/model/BpAnalyzeTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * 扣點統計item
 * Data: 2019-04-29
 */
class BpAnalyzeTableItem extends StatelessWidget {
  final BpAnalyzeViewModel defaultViewModel;
  final int dataCount;
  BpAnalyzeTableItem({this.defaultViewModel,this.dataCount});

  ///高分隔線
  _buildLineHeight(context) {
    return new Container(
      height: _titleHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線
  _buildLineHeightRed(context) {
    return new Container(
      height: _titleHeight(context),
      width: 1.0,
      color: Colors.red,
    );
  }

  ///取得裝置width並切10份
  _deviceWidth8(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 8;
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
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(width: 1.0,style: BorderStyle.solid,color: Colors.grey)
        )
      ),
      // height: height == null ? 25.0 : height,
      width: width,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _container(
      // height: _listHeight(context),
      child: Row(
        children: <Widget>[
          Container(
            width: (_deviceWidth8(context) * 2) - 1,
            child: _autoTextSize(defaultViewModel.name, TextStyle(color: Colors.black), context),
          ),
          _buildLineHeight(context),
          Container(
            width: _deviceWidth8(context) - 1,
            child: _autoTextSize('', TextStyle(color: Colors.black), context),
          ),
          _buildLineHeight(context),
          Container(
            width: _deviceWidth8(context) - 1,
            child: _autoTextSize(defaultViewModel.total, TextStyle(color: Colors.black), context),
          ),
          _buildLineHeightRed(context),
          Container(
            width: _deviceWidth8(context) - 1,
            child: _autoTextSize(defaultViewModel.inst, TextStyle(color: Colors.black), context),
          ),
          _buildLineHeightRed(context),
          Container(
            width: _deviceWidth8(context) - 1,
            child: _autoTextSize(defaultViewModel.fix, TextStyle(color: Colors.black), context),
          ),
          _buildLineHeight(context),
          Container(
            width: _deviceWidth8(context) - 1,
            child: _autoTextSize('', TextStyle(color: Colors.black), context),
          ),
          _buildLineHeight(context),
          Container(
            width: _deviceWidth8(context) - 1,
            child: _autoTextSize(defaultViewModel.points, TextStyle(color: Colors.red), context),
          ),
        ],
      ),
    );  
  }
}

class BpAnalyzeViewModel {

  BpAnalyzeViewModel();

  String name;//人員
  String inst;//裝機
  String fix;//維修
  String total;//小計
  String points;//扣點數

  BpAnalyzeViewModel.forMap(BpAnalyzeTableCell data) {
    name = data.Name == null ? "" : data.Name;
    inst = data.Inst == null ? "" : data.Inst;
    fix = data.Fix == null ? "" : data.Fix;
    total = data.Total == null ? "" : data.Total;
    points = data.Points == null ? "" : data.Points;
  }
}