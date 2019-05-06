
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * 操作說明頁面
 * Date: 2019-05-02
 */
class InstructionsDetailPage extends StatelessWidget {

  final leftContentArr = ["操作說明","全區▽","按自移","按點數","鎖HP","按重大","按上P","按工務","按問題","按派修","按超時","按板橋","PING"];
  final rightContenArr = ["","可選擇區域。","可查看機上盒在非原始裝機位置的客戶。","可查看工程人員點數管理。","可查看鎖HP,低HP戶數狀態。","可查看重大障礙。","可查上行POW > 51 的戶數。","可查看裝機,維修訊號異常戶。","可查看追蹤戶。","可查看當日寬頻異常戶派修戶數。","可查看長時間開機戶數(超時在下裡面)。","可查看卡板,HUB,NODE異常狀態。","可依客編PING該戶的參數。"];

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
  autoTextSize(text, style, BuildContext context) {
    var fontSize = MyScreen.normalPageFontSize_s(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  
  ///container
  _container({child, height, width}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
      width: width,
      child: child,
    );
  }
  ///container
  _containerLeft({child, height, width}) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
      width: width,
      child: child,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    
    ///迴圈跑內文
    for (var i = 0 ; i < leftContentArr.length; i++) {
      var leftArr = leftContentArr[i];
      var rightArr = rightContenArr[i];
      if (i == 0) {
        var content = _container(
          height: listHeight(context),
          child: autoTextSize('操作說明', TextStyle(color:Colors.black, fontWeight: FontWeight.bold ), context),
        );
        list.add(content);
      }
      else {
        var content =  Container(
        height: listHeight(context),
        child: Row(
          children: <Widget>[
            _container(
              width: deviceWidth4(context) - 1,
              child: autoTextSize(leftArr, TextStyle(color:Colors.black, fontWeight: FontWeight.bold ), context)
            ),
            buildLineHeight(context),
            _containerLeft(
              width: deviceWidth4(context) * 3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  autoTextSize(rightArr, TextStyle(color:Colors.black), context)
                ],
              )
            ),
          ],
        ),
      );
      list.add(content);
      }
      
    }
    
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: list,
      ),
    );
  }
} 