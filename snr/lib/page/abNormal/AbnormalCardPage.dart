import 'package:flutter/material.dart';
import 'package:snr/common/dao/AbnormalDao.dart';
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

class _AbnormalCardPageState extends State<AbnormalCardPage>  with AutomaticKeepAliveClientMixin<AbnormalCardPage>, MyListState<AbnormalCardPage> {
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
  ///取得api data
  getApiDataList() async {
    dataArray = [];
    var res = await AbnormalDao.getSNRSignalByCMTS(widget.CMTSCode);
    if (res != null && res.result) {
      setState(() {
        dataArray = res.data;
        isLoading = false;
      });
    }
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
              CommonUtils.getLocale(context).abnormal_card_hub, style: TextStyle(color: Colors.black)),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
              CommonUtils.getLocale(context).home_signal_online, style: TextStyle(color: Colors.blue)),
            )
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
              CommonUtils.getLocale(context).home_sinal_bad, style: TextStyle(color: Colors.red)),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
              CommonUtils.getLocale(context).home_signal_upP, style:TextStyle(color: Colors.black)),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
              CommonUtils.getLocale(context).home_signal_problem, style:TextStyle(color: Colors.pink)),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
              CommonUtils.getLocale(context).home_signal_percent, style:TextStyle(color: Colors.blue[300])
              ),
            ),
          )
        ],
      ),
    );

    
  }
  ///將body寫在這裡
  getBody() {
    return isLoading ? showProgressLoading() : new Material(
      child: new Center(
        child: new Container(
        color: Colors.yellow,
        child: _buildCmtsHeader1(),
      ),
      )
       
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
                new Text(widget.Name, style:TextStyle(fontSize: MyScreen.homePageFontSize(context))),
                new Text('data', style:TextStyle(fontSize:MyScreen.homePageFontSize(context)))

              ],
            ),
          )
        ],
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
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                text: "刷新",
                textColor: Colors.white,
                color: Colors.transparent,
                fontSize: MyScreen.homePageFontSize(context),
                onPress: () {
                 getApiDataList();
                },
              ),
            ),
           
            ButtonTheme(
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
                style: TextStyle(fontSize: MyScreen.homePageFontSize(context)),
              ),
              onPressed: () {
                print(123);
              },
            )),
            
            ButtonTheme(
              // minWidth: MyScreen.homePageBarButtonWidth(context),
              child: new MyToolButton(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                text: "返回",
                textColor: Colors.white,
                color: Colors.transparent,
                fontSize: MyScreen.homePageFontSize(context),
                mainAxisAlignment: MainAxisAlignment.start,
                onPress: () {
                  NavigatorUtils.goHome(context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }


}
