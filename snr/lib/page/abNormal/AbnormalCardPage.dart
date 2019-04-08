import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';

/**
 * 卡板列表頁面
 * Date: 2019-03-28
 */
class AbnormalCardPage extends StatefulWidget {
  static final String sName = "abnormalCard";

  final String CMTSCode;
  final String Name;
  final String Time;

  AbnormalCardPage(this.CMTSCode, this.Name, this.Time, {Key key})
      : super(key: key);

  @override
  _AbnormalCardPageState createState() => _AbnormalCardPageState();
}

class _AbnormalCardPageState extends State<AbnormalCardPage> with AutomaticKeepAliveClientMixin<AbnormalCardPage>, MyListState<AbnormalCardPage> {
  ///data 相關
  List<dynamic> dataArray = new List();
  List<dynamic> dataArray2 = new List();

  @override
  bool get isRefreshFirst => false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getApiDataList();
    xx();
  }
  xx() async {

    var dic  = await LocalStorage.get(Config.SNR_CONFIG);
    if (dic != null) {
      var dicMap = json.decode(dic);
      print('dic ===========> ${dicMap["DSSNR_MIN"]}');
    }
    
  }
  @override
  void dispose() {
    super.dispose();
  }

  ///取得api data
  getApiDataList() async {
    dataArray = [];
    dataArray2 = [];
    var res = await AbnormalDao.getSNRSignalByCMTS(widget.CMTSCode);
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data['Data'];
        dataArray2 = res.data['Data2'];
        // dataArray = res.data;
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

  _buildCmtsHeader1() {
    return new Container(
      height: 40.0,
      color: Color(MyColors.hexFromStr('#f5ffe9')),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                CommonUtils.getLocale(context).abnormal_card_hub,
                style: TextStyle(color: Colors.black, fontSize: MyScreen.normalPageFontSize(context)),
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

  /// cmts list
  _buildCmtsList1() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 44.0,
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
                                  dataArray[index]['CIF'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize(context)),
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
              NavigatorUtils.goAbnormalNode(context, widget.CMTSCode, dataArray[index]['CIF'], "${widget.Name} ${dataArray[index]['CIF']}", widget.Time);
            },
          );
        },
        itemCount: dataArray.length,
      ),
    );
  }
///cmts head title2
_buildCmtsHeader2() {
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
                CommonUtils.getLocale(context).abnormal_card_text,
                style: TextStyle(color: Colors.black, fontSize: MyScreen.normalPageFontSize(context)),
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
   /// cmts list2
  _buildCmtsList2() {
    return Expanded(
      child: Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 55.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: dataArray2 == null
                        ? []
                        : <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray2[index]['CIF'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize_s(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray2[index]['OnLine'],
                                  style: TextStyle(color: Colors.blue, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray2[index]['OverPower'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray2[index]['Problem'],
                                  style: TextStyle(color: Colors.black, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  dataArray2[index]['Bad'],
                                  style: TextStyle(color: Colors.red, fontSize: MyScreen.normalListPageFontSize(context)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  '${dataArray2[index]['BadRate']}%',
                                  style: TextStyle(color: Colors.pink, fontSize: MyScreen.normalListPageFontSize(context)),
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
              print(123);
            },
          );
        },
        itemCount: dataArray2 == null ? 0 : dataArray2.length,
      ),
     ),
    );
    
  }
  ///將body寫在這裡
  Widget getBody() {
    return isLoading
        ? showProgressLoading()
        : new Column(
            children: <Widget>[
              ///headtilte
              _buildCmtsHeader1(),
              _buildLine(),
              _buildCmtsList1(),
              _buildLine(),
              _buildCmtsHeader2(),
              _buildLine(),
              _buildCmtsList2(),
              _buildLine(),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              new Expanded(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text(widget.Name,
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context))),
                    new Text('         ',
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context))),
                    new Text('資料:${widget.Time}',
                        style: TextStyle(
                            fontSize: MyScreen.normalPageFontSize(context)))
                  ],
                ),
              )
            ],
            leading: Container(),
          ),

          ///body
          body: getBody(),

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
                    'PING',
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
        ));
  }
}
