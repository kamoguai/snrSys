import 'package:flutter/material.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
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
  }

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }
  ///list head
  _buildNodeHeader() {
    return new Container(
      height: 40.0,
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                CommonUtils.getLocale(context).abnormal_node_node,
                style: TextStyle(color: Colors.black, fontSize: MyScreen.normalPageFontSize_s(context)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Expanded(
              child: new Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              CommonUtils.getLocale(context).home_signal_online,
              style: TextStyle(color: Colors.blue, fontSize: MyScreen.normalPageFontSize(context)),
              textAlign: TextAlign.center,
            ),
          )),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                CommonUtils.getLocale(context).home_signal_upP,
                style: TextStyle(color: Colors.black, fontSize: MyScreen.normalPageFontSize(context)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                CommonUtils.getLocale(context).home_signal_problem,
                style: TextStyle(color: Colors.black, fontSize: MyScreen.normalPageFontSize(context)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                CommonUtils.getLocale(context).home_sinal_bad,
                style: TextStyle(color: Colors.red, fontSize: MyScreen.normalPageFontSize(context)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                CommonUtils.getLocale(context).home_signal_percent,
                style: TextStyle(color: Colors.pink, fontSize: MyScreen.normalPageFontSize(context)),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
  /// node list
  _buildNodeList() {
    return Container(
      child: Expanded(
        child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 50.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: dataArray == null
                        ? []
                        : <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray[index]['NODE'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize_s(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray[index]['OnLine'],
                                  style: TextStyle(color: Colors.blue, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray[index]['OverPower'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray[index]['Problem'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray[index]['Bad'],
                                  style: TextStyle(color: Colors.red, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  '${((double.parse(dataArray[index]['BadRate']) * 1000) / 10).toStringAsFixed(1)}%',
                                  style: TextStyle(color: Colors.blue, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                  ),
                  _buildLine()
                ],
              ),
            ),
            onTap: () {
              // NavigatorUtils.goAbnormalNode(context, widget.CMTSCode, dataArray[index]['CIF'], "${widget.Name} ${dataArray[index]['CIF']}", widget.Time);
            },
          );
        },
        itemCount: dataArray.length,
      ),
      )
      
    );
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
                    'DCTV',
                    style:
                        TextStyle(fontSize: MyScreen.normalPageFontSize(context)),
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
      ),
    );
  }
}