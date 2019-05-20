
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * 基本widget，供重複使用的widget
 * Date: 2019-05-09
 */
mixin BaseWidget{
  ///是否讀取中
  var isLoading = false;
  ///讀取用dialog
  showLoadingDialog(BuildContext context){
    Widget dialog;
    showDialog(
      context: context,
      builder: (BuildContext context) => dialog
    );
    dialog =  Material(
      type: MaterialType.transparency,
      child: Center(
       child: new Container(
        width: 150.0,
          height: 150.0,
          padding: new EdgeInsets.all(4.0),
          decoration: new BoxDecoration(
            color: Colors.black45,
            //用一个BoxDecoration装饰器提供背景图片
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(child: SpinKitCubeGrid(color: Colors.white)),
              new Container(height: 10.0),
              new Container(child: new Text(CommonUtils.getLocale(context).loading_text, style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(20.0)))),
            ],
          ),
        )
      ),
    );
  }
  ///讀取結束用
  hidenLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
  ///anime loding
  showLoadingAnime(BuildContext context) {
    return Center(
      child: new Container(
        width: 150.0,
        height: 150.0,
        padding: new EdgeInsets.all(4.0),
        decoration: new BoxDecoration(
          color: Colors.black45,
          //用一个BoxDecoration装饰器提供背景图片
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(child: SpinKitCubeGrid(color: Colors.white)),
            new Container(height: 10.0),
            new Container(child: new Text(CommonUtils.getLocale(context).loading_text, style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(20.0)))),
          ],
        ),
      )
    );
  }

  ///分隔線
  buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線
  buildLineHeight(BuildContext context) {
    return new Container(
      height: titleHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }
  ///高分隔線-red
  buildLineHeightRed(BuildContext context) {
    return new Container(
      height: titleHeight(context),
      width: 1.0,
      color: Colors.red,
    );
  }

  ///高分隔線
  buildRedLineHeight(BuildContext context) {
    return new Container(
      height: titleHeight(context),
      width: 1.0,
      color: Colors.red,
    );
  }

  ///取得裝置width並切2份
  deviceWidth2(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 2;
  }

   ///取得裝置width並切3份
  deviceWidth3(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 3;
  }

   ///取得裝置width並切4份
  deviceWidth4(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 4;
  }

  ///取得裝置width並切5份
  deviceWidth5(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 5;
  }

  ///取得裝置width並切6份
  deviceWidth6(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }

  ///取得裝置width並切7份
  deviceWidth7(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 7;
  }

  ///取得裝置width並切8份
  deviceWidth8(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return width / 8;
  }

  ///取得裝置height切4分
  deviceHeight4(BuildContext context) {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  listHeight(BuildContext context) {
    var height = deviceHeight4(context);
    return height / 5;
  }

  ///title height
  titleHeight(BuildContext context) {
    var height = deviceHeight4(context);
    return height / 4;
  }

  ///自動縮放-中
  autoTextSize(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  ///自動縮放-左
  autoTextSizeLeft(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.left,
    );
  }
}