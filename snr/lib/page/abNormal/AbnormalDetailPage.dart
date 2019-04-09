import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyToolBarButton.dart';

class AbnormalDetailPage extends StatefulWidget {
  static final String sName = "abnormalDetial";
  final String cmtsCodeStr;
  final String cifStr;
  final String nodeStr;
  final String timeStr;
  AbnormalDetailPage(this.cmtsCodeStr, this.cifStr, this.nodeStr, this.timeStr,
      {Key key})
      : super(key: key);
  @override
  _AbnormalDetailPageState createState() => _AbnormalDetailPageState();
}

class _AbnormalDetailPageState extends State<AbnormalDetailPage> with AutomaticKeepAliveClientMixin<AbnormalDetailPage>, MyListState<AbnormalDetailPage> {

  var config;
  //列表顯示的物件
  _renderItem(index) {
    DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
    DefaultViewModel model = DefaultViewModel.forMap(dtc);
    return new DefaultTableItem(model, config);
  }

  //讀取snr config
  _localConfig() async {
    final configData = await LocalStorage.get(Config.SNR_CONFIG);
    final dic = json.decode(configData);
    config = dic;
  }

  ///call api data
  getApiDataList() async {
    var res = await AbnormalDao.getSNRDetailByCMTSAndCIF(_getStore(),
        cmts: widget.cmtsCodeStr,
        cif: widget.cifStr,
        node: widget.nodeStr,
        type: '',
        sort: '');
    return res;
  }
  _reloadAction() async {
    
    isLoading = showRefreshLoading();
    var res = await getApiDataList();
    if (res != null && res.result) {
      setState(() {
        clearData();
        pullLoadWidgetControl.dataList.addAll(res.data);
        pullLoadWidgetControl.needLoadMore = false;
      });
    }

    isLoading = false;
  }
  Store<SysState> _getStore() {
    return StoreProvider.of(context);
  }

  //透過override pullcontroller裡面的handleRefresh覆寫數據
  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    var res = await getApiDataList();
    if (res != null && res.result) {
      setState(() {
        clearData();
        pullLoadWidgetControl.dataList.addAll(res.data);
        pullLoadWidgetControl.needLoadMore = false;
      });
    }

    isLoading = false;
    return null;
  }

  @override
  void initState() {
    super.initState();
    _localConfig();
  }

  @override
  void didChangeDependencies() {
    var list = _getStore().state.defaultList;
    pullLoadWidgetControl.dataList = list;
    if (pullLoadWidgetControl.dataList.length == 0) {
      setState(() {});
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    clearData();
  }

  @override
  bool get isRefreshFirst => false;

  @override
  requestRefresh() async {
    return null;
  }

  @override
  requestLoadMore() async {
    return null;
  }

  var nowType = switchType.big;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        top: false,
        child: new StoreBuilder<SysState>(
          builder: (context, store) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                actions: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ButtonTheme(
                          child: MyToolButton(
                            padding: EdgeInsets.all(1.0),
                            text: '異常',
                            textColor: nowType == switchType.big ? Colors.yellow : Colors.white,
                            fontSize: MyScreen.normalPageFontSize(context),
                            onPress: () {
                              setState(() {
                                nowType = switchType.big;
                              });
                            },
                          ),
                        ),
                        ButtonTheme(
                          child: MyToolButton(
                            padding: EdgeInsets.all(1.0),
                            text: '上P',
                            textColor: nowType == switchType.power ? Colors.yellow : Colors.white,
                            fontSize: MyScreen.normalPageFontSize(context),
                            onPress: () {
                              setState(() {
                                nowType = switchType.power;
                              });
                            },
                          ),
                        ),
                        ButtonTheme(
                          child: MyToolButton(
                            padding: EdgeInsets.all(1.0),
                            text: '問題',
                            textColor: nowType == switchType.problem ? Colors.yellow : Colors.white,
                            fontSize: MyScreen.normalPageFontSize(context),
                            onPress: () {
                              setState(() {
                                nowType = switchType.problem;
                              });
                            },
                          ),
                        ),
                        Text('資料:${widget.timeStr}',
                            style: TextStyle(
                                fontSize: MyScreen.normalPageFontSize(context))),
                      ],
                    ),
                  )
                ],
                leading: Container(),
              ),
              body: MyPullLoadWidget(
                pullLoadWidgetControl,
                (BuildContext context, int index) => _renderItem(index),
                handleRefresh,
                onLoadMore,
                refreshKey: refreshIndicatorKey,
              ),
              bottomNavigationBar: new Material(
                color: Theme.of(context).primaryColor,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ButtonTheme(
                      // minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        // padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: EdgeInsets.all(1.0),
                        text: "刷新",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                          isLoading = true;
                          setState(() {
                            _reloadAction();
                            print(123);
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                        // padding: EdgeInsets.all(1.0),
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
                            fontSize: MyScreen.normalPageFontSize(context)),
                      ),
                      onPressed: () {
                        print(123);
                      },
                    )),
                    ButtonTheme(
                      // minWidth: MyScreen.homePageBarButtonWidth(context),
                      child: new MyToolButton(
                        // padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        padding: EdgeInsets.all(1.0),
                        text: "返回",
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        mainAxisAlignment: MainAxisAlignment.start,
                        onPress: () {
                          //返回上一頁
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
///app bar button enum
enum switchType{
  big,
  power,
  problem
}