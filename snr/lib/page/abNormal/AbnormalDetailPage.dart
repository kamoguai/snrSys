import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/widget/DefaultTableItem.dart';
import 'package:snr/widget/MyPullLoadWidget.dart';
import 'package:snr/widget/MyListState.dart';

class AbnormalDetialPage extends StatefulWidget {
  static final String sName = "abnormalDetial";
  final String cmtsCodeStr;
  final String cifStr;
  final String nodeStr;

  AbnormalDetialPage(this.cmtsCodeStr, this.cifStr, this.nodeStr, {Key key})
      : super(key: key);
  @override
  _AbnormalDetialPageState createState() => _AbnormalDetialPageState();
}

class _AbnormalDetialPageState extends State<AbnormalDetialPage>
    with
        AutomaticKeepAliveClientMixin<AbnormalDetialPage>,
        MyListState<AbnormalDetialPage> {
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
  var config ;
  _renderItem(index) {
 
     DefaultTableCell dtc = pullLoadWidgetControl.dataList[index];
     DefaultViewModel model = DefaultViewModel.forMap(dtc);
     return new DefaultTableItem(model, config);
 
    
  }

  _localConfig() async{
    final configData = await LocalStorage.get(Config.SNR_CONFIG);
    final dic = json.decode(configData);
    config = dic;
  }

  Store<SysState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    var res =  await AbnormalDao.getSNRDetailByCMTSAndCIF(_getStore(),
        cmts: widget.cmtsCodeStr,
        cif: widget.cifStr,
        node: widget.nodeStr,
        type: '',
        sort: '');
    if (res != null && res.result) {
      setState(() {
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
    if(pullLoadWidgetControl.dataList.length == 0) {
      setState(() {

      });
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
  Widget build(BuildContext context) {
    super.build(context);

    return new StoreBuilder<SysState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: MyPullLoadWidget(
            pullLoadWidgetControl,
            (BuildContext context, int index) =>
                _renderItem(index),
            handleRefresh,
            onLoadMore,
            refreshKey: refreshIndicatorKey,
          ),
        );
      },
    );
  }
}
