
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * 操作說明頁面
 * Date: 2019-05-02
 */
class InstructionsDetailPage extends StatelessWidget {

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
      height: titleHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切6份
  deviceWidth4(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 4;
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
  autoTextSize(text, color, BuildContext context) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  
  ///container
  _container({child, height, width}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border()),
      width: width,
      child: child,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _container(
          // height: listHeight(context),
          child: autoTextSize('操作說明', Colors.black, context),
        ),
        buildLine(),
        Container(
          child: Row(
            children: <Widget>[
              _container(
                width: deviceHeight4(context) - 1,
                child: autoTextSize('全區▽', Colors.black, context)
              ),
              buildLineHeight(context),
              _container(
                width: deviceHeight4(context) * 3,
                child: autoTextSize('可選擇區域。', Colors.black, context)
              ),
            ],
          ),
        )
      ],
    );
  }
}