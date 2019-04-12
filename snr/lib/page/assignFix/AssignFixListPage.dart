

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/dao/AssignFixDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyListState.dart';
/**
 * 派修列表頁面
 * Date: 2019-04-12
 */
class AssignFixListPage extends StatefulWidget {
  @override
  _AssignFixListPageState createState() => _AssignFixListPageState();
}

class _AssignFixListPageState extends State<AssignFixListPage> with AutomaticKeepAliveClientMixin<AssignFixListPage>, MyListState<AssignFixListPage>{
  
  ///data 相關
  List<dynamic> dataArray = new List();
  List<dynamic> dataArray2 = new List();

  ///取得data api
  getApiDataList() async {
    var res = await AssignFixDao.getQueryAssignFixList();
    var res2 = await AssignFixDao.getBuildAnalyse('FIX');
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data;
      });
    }
    if (res2 != null && res2.result) {
      setState(() {
        dataArray2 = res2.data;
      });
    }
    if (dataArray != [] && dataArray2 != [] ) {
      isLoading = false;
    }
  }
  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///高分隔線
  _buildLineHeight() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.grey,
    );
  }
    ///高分隔線
  _buildRedLineHeight() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.red,
    );
  }
  ///取得裝置width並切6份
  _deviceWidth6() {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
  }
  ///取得裝置width並切6份
  _deviceWidth8() {
    var width = MediaQuery.of(context).size.width;
    return width / 8;
  }
  ///取得裝置height切4分
  _deviceHeight4() {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }
  ///lsit height
  _listHeight() {
    var height = _deviceHeight4();
    return height / 5;
  }
  ///title height
  _titleHeight() {
    var height = _deviceHeight4();
    return height / 4;
  }
  ///間隔8
  _dummyHeight() {
    return SizedBox(height: 8.0,);
  }
  ///自動字大小
  Widget _autoTextSize(text, style) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);

    return AutoSizeText(
      text,
      style: style,
      maxFontSize: fontSize,
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
 ///list title
 Widget _buildAssignFixListHeader1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fef5f6')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize('CMTS', TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_assignFix, TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_fix2, TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_cut, TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_watch, TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).text_total_s, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  Widget _buildAssignFixListItem(BuildContext context, int index) {
    var dic = dataArray[index];
    return GestureDetector(
      child: Container(
        height: _listHeight(),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid
          ))
        ),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: _deviceWidth6() - 1,
                  child: _autoTextSize(dic["Name"], TextStyle(color: Colors.black)),
                ),
                _buildLineHeight(),
                Container(
                  width: _deviceWidth6() - 1,
                  child: _autoTextSize(dic["FIX"], TextStyle(color: Colors.brown)),
                ),
                _buildLineHeight(),
                Container(
                  width: _deviceWidth6() - 1,
                  child: _autoTextSize(dic["FIX2"], TextStyle(color: Colors.brown)),
                ),
                _buildLineHeight(),
                Container(
                  width: _deviceWidth6() - 1,
                  child: _autoTextSize(dic["CUT"], TextStyle(color: Colors.blue)),
                ),
                _buildLineHeight(),
                Container(
                  width: _deviceWidth6() - 1,
                  child: _autoTextSize(dic["WATCH"], TextStyle(color: Colors.blue)),
                ),
                _buildLineHeight(),
                Container(
                  width: _deviceWidth6(),
                  child: _autoTextSize(dic["TOTAL"], TextStyle(color: Colors.black)),
                ),
              ],
            ),
      ),
      onTap: (){
        print('cell click');
      },
    );

  }
  Widget _buildAssignFixListBody() {
    Widget assignFixList;
    if(dataArray.length > 0) {
      assignFixList = Container(
        height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildAssignFixListItem,
          itemCount: dataArray.length,
        ),
      );
    }
    else {
      assignFixList = Container();
    }
    return assignFixList;
  }

  ///list bottom
  Widget _buildAssignFixListBottom1() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fce7f8')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_total, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).home_btn_assignFix, TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_fix2, TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_cut, TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_watch, TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).text_total_s, TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  ///building title
  Widget _buildBuildingListHeader() {
    return new Container(
      height: _titleHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: (_deviceWidth8() * 3) - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_buildingName, TextStyle(color: Colors.black,)),
          ),
          _buildLineHeight(),
          Container(
            width: _deviceWidth8() - 1,
            child: _autoTextSize(CommonUtils.getLocale(context).text_buildingName, TextStyle(color: Colors.black,)),
          ),
          _buildRedLineHeight(),
          
        ],
      ),
    );
  }
  ///widget body
  Widget getBody() {
    if(isLoading) {
      return showProgressLoading();
    }
    else {
      return Column(
        children: <Widget>[
          _buildAssignFixListHeader1(),
          _buildLine(),
          _buildAssignFixListBody(),
          _buildLine(),
          _buildAssignFixListBottom1(),
          _buildLine(),
          _dummyHeight(),
          _buildLine(),
        ],
      );
    }
  }
  @override
  void initState() {
    super.initState();
    isLoading = true;
    getApiDataList();
  }
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  bool get isRefreshFirst => false;
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: getBody(),
      ),
    );
  }
}