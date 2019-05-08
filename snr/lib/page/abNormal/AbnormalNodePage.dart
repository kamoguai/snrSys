import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyListState.dart';

class AbnormalNodePage extends StatefulWidget {
  
  static final String sName = "abnormalNode";

  final String cmtsCodeStr;
  final String cifStr;
  final String nameStr;
  final String timeStr;


  AbnormalNodePage(this.cmtsCodeStr, this.cifStr, this.nameStr, this.timeStr, {Key key}) : super(key: key);

  @override
  _AbnormalNodePageState createState() => _AbnormalNodePageState();
}

class _AbnormalNodePageState extends State<AbnormalNodePage> with AutomaticKeepAliveClientMixin<AbnormalNodePage>, MyListState<AbnormalNodePage> {

 ///data 相關
  List<dynamic> dataArray = new List();
  @override
  bool get isRefreshFirst => false;

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

  /// call api
  getApiDataList() async {
    dataArray = [];
    var res = await AbnormalDao.getSNRSignalByCmtsAndCif(widget.cmtsCodeStr, widget.cifStr);
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data;
        isLoading = false;
      });
    }
    else {
      setState(() {
        isLoading = false;
      });
    }
  }

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

   ///取得裝置width並切6份
  _deviceWidth6() {
    var width = MediaQuery.of(context).size.width;
    return width / 6;
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

  ///自動字大小
  Widget _autoTextSize(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  
  ///list head
  _buildNodeHeader() {
    return new Container(
      height: _titleHeight(),
      color: Color(MyColors.hexFromStr('#fef5f6')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).abnormal_node_node, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_online, Colors.blue),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_upP, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_problem, Colors.black),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_sinal_bad, Colors.red),
          ),
          Container(
            width: _deviceWidth6(),
            child: _autoTextSize(CommonUtils.getLocale(context).home_signal_percent, Colors.pink),
          ),
          
        ],
      ),
    );
  }
  ///node list item
  Widget _buildNodeListItem(BuildContext context, int index) {
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
              width: _deviceWidth6(),
              child: _autoTextSize(dic["NODE"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["OnLine"], Colors.blue),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["OverPower"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["Problem"], Colors.black),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize(dic["Bad"], Colors.red),
            ),
            Container(
              width: _deviceWidth6(),
              child: _autoTextSize('${((double.parse(dic['BadRate']) * 1000) / 10).toStringAsFixed(1)}%', Colors.blue),
            ),
          ],
        ),
      ),
      onTap: (){
        NavigatorUtils.goAbnormalDetail(context, widget.cmtsCodeStr, widget.cifStr, dic['NODE'], widget.timeStr);
      },
    );
  }
  /// node list
  Widget _buildNodeList() {
    Widget nodeList;
    if (dataArray != null && dataArray.length > 0) {
      nodeList = Expanded(
        // height: _deviceHeight4(),
        child: ListView.builder(
          itemBuilder: _buildNodeListItem,
          itemCount: dataArray.length,
        ),
      );
    }
    else {
      nodeList = Container(child: buildEmpty());
    }
    return nodeList;
  }
  Widget getBodyData() {
    return isLoading ? showProgressLoading() : Column(
      children: <Widget>[
        _buildNodeHeader(),
        _buildLine(),
        _buildNodeList()

      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(widget.nameStr, style: TextStyle(fontSize: MyScreen.normalPageFontSize(context))),
                  Text(CommonUtils.getLocale(context).abnormal_node_title, style: TextStyle(fontSize: MyScreen.normalPageFontSize(context))),
                  Text('資料:${widget.timeStr}', style: TextStyle(fontSize: MyScreen.normalPageFontSize(context))),
                ],
              ),
            )
          ],
          leading: Container(),
        ),
        body: getBodyData(),
        ///toolBar
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
                        getApiDataList();
                      });
                    },
                  ),
                ),
                Container(
                  height: 30,
                  child: FlatButton.icon(
                    icon: Image.asset('static/images/23.png'),
                    color: Colors.transparent,
                    label: Text(''),
                    onPressed: (){

                    },
                  ),
                ),
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
                        //返回上一頁
                         Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}