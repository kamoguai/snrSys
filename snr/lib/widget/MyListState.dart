import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';

/**
 * 上下拉刷新列表的通用State
 *
 * Date: 2019-03-20
 */
mixin MyListState<T extends StatefulWidget> on State<T>, AutomaticKeepAliveClientMixin<T> {
  bool isShow = false;

  bool isLoading = false;

  int page = 1;
  ///用於區域條件查詢
  String strCity = "";
  ///用於sort條件查詢
  String strSort = "";

  final List dataList = new List();

  final MyPullLoadWidgetControl pullLoadWidgetControl = new MyPullLoadWidgetControl();

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ///轉圈圈loading
  showProgressLoading() {
    return new Center(child: new CircularProgressIndicator());
  }
  ///運用MyPullLoadWidget
  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      refreshIndicatorKey.currentState.show().then((e) {});
      return true;
    });
  }
  ///anime loding
  showLoadingAnime(BuildContext context) {
    return Center(
      child: new Container(
        width: 150.0,
        height: 150.0,
        padding: new EdgeInsets.all(4.0),
        decoration: new BoxDecoration(
          color: Colors.transparent,
          //用一个BoxDecoration装饰器提供背景图片
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(child: SpinKitCubeGrid(color: Colors.blue[200])),
            new Container(height: 10.0),
            new Container(child: new Text(CommonUtils.getLocale(context).loading_text, style: TextStyle(color: Colors.black))),
          ],
        ),
      )
    );
  }
  ///運用MyPullLoadWidget
  showRefreshLoadingF() {
    new Future.delayed(const Duration(seconds: 0), () {
      refreshIndicatorKey.currentState.show().then((e) {});
      return false;
    });
  }
  ///空页面
  buildEmpty() {
    return new Expanded(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: new Image(image: new AssetImage(MyICons.DEFAULT_USER_ICON), width: 70.0, height: 70.0),
          ),
          Container(
            child: Text(CommonUtils.getLocale(context).app_empty, style: MyConstant.normalText),
          ),
        ],
      ),
    );
  }
  ///排序dialog, ios樣式
  showSortAlertSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text(CommonUtils.getLocale(context).text_sort),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = 'T';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_time),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = 'A';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_address),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strSort = 'B';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_building),
              ),
            ],
          );
          
          return dialog;
        }
    );
  }

  ///查詢dialog, ios樣式
  showSearchAlertSheetController(BuildContext context, dataArray) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text(CommonUtils.getLocale(context).text_sort),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: <Widget>[
              // CupertinoActionSheetAction(
              //   onPressed: () {
              //     Navigator.pop(context);
              //     _showQeuryCustNo(context);
              //   },
              //   child: Text(CommonUtils.getLocale(context).text_custcode),
              // ),
              CupertinoActionSheetAction(
                onPressed: () {
                 setState(() {
                    List<DefaultTableCell> list = new List();
                    pullLoadWidgetControl.dataList.clear();
                    for (var dic in dataArray) {
                      if (dic["BAD_TYPE"] == "C") {
                        list.add(DefaultTableCell.fromJson(dic));
                      }
                    }
                    pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text('CH'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    List<DefaultTableCell> list = new List();
                    pullLoadWidgetControl.dataList.clear();
                    for (var dic in dataArray) {
                      if (dic["BAD_TYPE"] == "S") {
                        list.add(DefaultTableCell.fromJson(dic));
                      }
                    }
                    pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text('SNR'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    List<DefaultTableCell> list = new List();
                    pullLoadWidgetControl.dataList.clear();
                    for (var dic in dataArray) {
                      if (dic["BB"] != "內網") {
                        list.add(DefaultTableCell.fromJson(dic));
                      }
                    }
                    pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_extranet),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                   List<DefaultTableCell> list = new List();
                    pullLoadWidgetControl.dataList.clear();
                    for (var dic in dataArray) {
                      if (dic["BB"] == "內網") {
                        list.add(DefaultTableCell.fromJson(dic));
                      }
                    }
                    pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_intranet),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                   List<DefaultTableCell> list = new List();
                    pullLoadWidgetControl.dataList.clear();
                    for (var dic in dataArray) {
                      if (dic["Status"] == "1") {
                        list.add(DefaultTableCell.fromJson(dic));
                      }
                    }
                    pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_online),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                   List<DefaultTableCell> list = new List();
                    pullLoadWidgetControl.dataList.clear();
                    for (var dic in dataArray) {
                      if (dic["Status"] == "0") {
                        list.add(DefaultTableCell.fromJson(dic));
                      }
                    }
                    pullLoadWidgetControl.dataList.addAll(list);
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_offline),
              ),
            ],
          );
          
          return dialog;
        }
    );
  }

  ///地區dialog, ios樣式
  showCityAlertSheetController(BuildContext context) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (context) {
          var dialog = CupertinoActionSheet(
            title: Text(CommonUtils.getLocale(context).text_sort),
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: Text('取消'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = '';
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_all),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_bq;;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_bq),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_sc;;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_sc),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_xz;;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_xz),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_tc;;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_tc),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    strCity = CommonUtils.getLocale(context).text_lu;;
                    showRefreshLoading();
                  });
                  Navigator.pop(context);
                },
                child: Text(CommonUtils.getLocale(context).text_lu),
              ),
            ],
          );
          
          return dialog;
        }
    );
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
  buildRedLineHeight() {
    return new Container(
      height: titleHeight(),
      width: 1.0,
      color: Colors.red,
    );
  }

  ///高分隔線
  buildLineHeight() {
    return new Container(
      height: titleHeight(),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線
  buildLineHeightDouble() {
    return new Container(
      height: titleHeight() * 2,
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切6份
  deviceWidth4() {
    var width = MediaQuery.of(context).size.width;
    return width / 4;
  }

  ///取得裝置width並切6份
  deviceWidth6() {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }

  ///取得裝置width並切7份
  deviceWidth7() {
    var width = MediaQuery.of(context).size.width;
    return width / 7;
  }

  ///取得裝置width並切8份
  deviceWidth8() {
    var width = MediaQuery.of(context).size.width;
    return width / 8;
  }

  ///取得裝置width並切9份
  deviceWidth9() {
    var width = MediaQuery.of(context).size.width;
    return width / 9;
  }

  ///取得裝置width並切10份
  deviceWidth10(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 10;
  }

  ///取得裝置width並切8份*2
  deviceWidth82() {
    var width = MediaQuery.of(context).size.width;
    return (width / 8) * 2;
  }
  ///取得裝置width並切8份*3
  deviceWidth83() {
    var width = MediaQuery.of(context).size.width;
    return (width / 8) * 3;
  }

  ///取得裝置height切4分
  deviceHeight4() {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  listHeight() {
    var height = deviceHeight4();
    return height / 5;
  }

  ///title height
  titleHeight() {
    var height = deviceHeight4();
    return height / 4;
  }

  ///自動字大小
  autoTextSize(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  
  ///自動字大小靠左
  Widget autoTextSizeLeft(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.left,
    );
  }

  @protected
  resolveRefreshResult(res) {
    if (res != null && res.result) {
      pullLoadWidgetControl.dataList.clear();
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(res.data);
        });
      }
    }
  }

  @protected
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;
    var res = await requestRefresh();
    resolveRefreshResult(res);
    resolveDataResult(res);
    if (res.next != null) {
      var resNext = await res.next;
      resolveRefreshResult(resNext);
      resolveDataResult(resNext);
    }
    isLoading = false;
    return null;
  }

  @protected
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    var res = await requestLoadMore();
    if (res != null && res.result) {
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(res.data);
        });
      }
    }
    resolveDataResult(res);
    isLoading = false;
    return null;
  }

  @protected
  resolveDataResult(res) {
    if (isShow) {
      setState(() {
        pullLoadWidgetControl.needLoadMore = (res != null && res.data != null && res.data.length == Config.PAGE_SIZE);
      });
    }
  }

  @protected
  clearData() {
    if (isShow) {
      setState(() {
        strCity = "";
        strSort = "";
        pullLoadWidgetControl.dataList.clear();
      });
    }
  }

  ///下拉刷新数据
  @protected
  requestRefresh() async {}

  ///上拉更多请求数据
  @protected
  requestLoadMore() async {}

  ///是否需要第一次进入自动刷新
  @protected
  bool get isRefreshFirst;

  ///是否需要头部
  @protected
  bool get needHeader => false;

  ///是否需要保持
  @override
  bool get wantKeepAlive => true;

  List get getDataList => dataList;

  @override
  void initState() {
    isShow = true;
    super.initState();
    pullLoadWidgetControl.needHeader = needHeader;
    pullLoadWidgetControl.dataList = getDataList;
    if (pullLoadWidgetControl.dataList.length == 0 && isRefreshFirst) {
      showRefreshLoading();
    }
  }

  @override
  void dispose() {
    isShow = false;
    isLoading = false;
    super.dispose();
  }
}
