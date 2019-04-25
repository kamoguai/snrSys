import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/dialog/SmallPingTableItem.dart';

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
  final List<String> toTransformArray = [];
  //列表顯示的物件
  _renderItem(index) {
    DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
    DefaultViewModel model = DefaultViewModel.forMap(dtc);
    return new DefaultTableItem(defaultViewModel: model, configData: config, addTransform: _addTransform, addTransformArray: toTransformArray, callPing: _callPing, currentCellTag: index,);
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
  ///呼叫小ping api
  getPingData(custCode) async {
    var res = await DefaultTableDao.getPingSNR(_getStore(),context, custCode: custCode);
    return res;
  }
  ///跳轉function 
  void _addTransform(String custNo) {
    setState(() {
      if (toTransformArray.contains(custNo)) {
        var index = toTransformArray.indexOf(custNo);
        toTransformArray.removeAt(index);
      }
      else {
        toTransformArray.add(custNo);
      }
    });
  }
  ///小ping function
  void _callPing(String custCode, int currentCellTag) async{
    if (isLoading) {
      Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
      return;
    }
    isLoading = true;
    Fluttertoast.showToast(msg: '正在ping該筆資料中..');
    var res = await getPingData(custCode);
    if(res != null && res.result) {
      // var pingData = _getStore().state.pingData;
      showDialog(
      context: context,
      builder: (BuildContext context) => _buildPingDialog(context,res, currentCellTag: currentCellTag)
      );
      isLoading = false;
      
    }
    
  }
 ///小ping dialog
  Widget _buildPingDialog(BuildContext context, res, {currentCellTag}) {
    SmallPingTableCell sptc = SmallPingTableCell.fromJson(res.data);
    PingViewModel model = PingViewModel.forMap(sptc);
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: SmallPingTableItem(defaultViewModel: model, configData: config,),
          ),
          SizedBox(height: 20,),
         Card(
            color: Color(MyColors.hexFromStr("#ebf6f9")),
            child: ButtonTheme(
              minWidth: double.maxFinite,
              child: FlatButton(
                child: Text(CommonUtils.getLocale(context).text_leave, style: TextStyle(color: Colors.red, fontSize: MyScreen.homePageFontSize(context))),
                onPressed: (){
                  ///資料回填當前row cell
                  var pingRes = _getStore().state.pingtData;
                  var dic = pullLoadWidgetControl.dataList[currentCellTag];
                
                  setState(() {
                    
                    Map<String,dynamic> u = {};
                    Map<String, dynamic> snr = {};
                    if (pingRes.SNR != null) {
                      u = pingRes.SNR["U0"];
                      snr = u;
                      dic.U0_SNR = snr["SNR"];
                      dic.U0_PWR = snr["PWR"];
                      u = pingRes.SNR["U1"];
                      snr = u;
                      dic.U1_SNR = snr["SNR"];
                      dic.U1_PWR = snr["PWR"];
                      u = pingRes.SNR["U2"];
                      snr = u;
                      dic.U2_SNR = snr["SNR"];
                      dic.U2_PWR = snr["PWR"];
                      u = pingRes.SNR["U3"];
                      snr = u;
                      dic.U3_SNR = snr["SNR"];
                      dic.U3_PWR = snr["PWR"];
                    }
                    Map<String,dynamic> c = {};
                    u = pingRes.CodeWord["U0"];
                    c = u;
                    dic.U0U = c["U"];
                    dic.U0C = c["C"];
                    u = pingRes.CodeWord["U1"];
                    c = u;
                    dic.U1U = c["U"];
                    dic.U1C = c["C"];
                    u = pingRes.CodeWord["U2"];
                    c = u;
                    dic.U2U = c["U"];
                    dic.U2C = c["C"];
                    u = pingRes.CodeWord["U3"];
                    c = u;
                    dic.U3U = c["U"];
                    dic.U3C = c["C"];

                    dic.DS0 = pingRes.DS0;
                    dic.DS1 = pingRes.DS1;
                    dic.DS2 = pingRes.DS2;
                    dic.DS3 = pingRes.DS3;
                    dic.DS4 = pingRes.DS4;
                    dic.DS5 = pingRes.DS5;
                    dic.DS6 = pingRes.DS6;
                    dic.DS7 = pingRes.DS7;
                    dic.DP0 = pingRes.DP0;
                    dic.DP1 = pingRes.DP1;
                    dic.DP2 = pingRes.DP2;
                    dic.DP3 = pingRes.DP3;
                    dic.DP4 = pingRes.DP4;
                    dic.DP5 = pingRes.DP5;
                    dic.DP6 = pingRes.DP6;
                    dic.DP7 = pingRes.DP7;

                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
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
                              if (isLoading) {
                                Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                                return;
                              }
                              setState(() {
                                nowType = switchType.big;
                                showRefreshLoading();
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
                              if (isLoading) {
                                Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                                return;
                              }
                              setState(() {
                                nowType = switchType.power;
                                showRefreshLoading();
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
                              if (isLoading) {
                                Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                                return;
                              }
                              setState(() {
                                nowType = switchType.problem;
                                showRefreshLoading();
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
                        text: CommonUtils.getLocale(context).text_refresh,
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        onPress: () {
                          if (isLoading) {
                            Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                            return;
                          }
                          setState(() {
                            showRefreshLoading();
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
                        text: CommonUtils.getLocale(context).text_back,
                        textColor: Colors.white,
                        color: Colors.transparent,
                        fontSize: MyScreen.normalPageFontSize(context),
                        mainAxisAlignment: MainAxisAlignment.start,
                        onPress: () {
                          if (isLoading) {
                            Fluttertoast.showToast(msg: CommonUtils.getLocale(context).loading_text);
                            return;
                          }
                          setState(() {
                            clearData();
                            //返回上一頁
                            Navigator.pop(context);
                          });
                         
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