import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';

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

class _AbnormalCardPageState extends State<AbnormalCardPage> {

  @override
  void dispose() {
    super.dispose();
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

        ],
      ),

      ///toolBar
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonTheme(
              minWidth: MyScreen.homePageBarButtonWidth(context),
              child: new MyToolButton(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                text: "刷新",
                textColor: Colors.white,
                color: Colors.transparent,
                fontSize: MyScreen.homePageFontSize(context),
                onPress: () {
                  // isLoading = true;
                  setState(() {});
                },
              ),
            ),
            ButtonTheme(
              minWidth: MyScreen.homePageBarButtonWidth(context),
              child: new MyToolButton(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                text: "分析",
                textColor: Colors.white,
                color: Colors.transparent,
                fontSize: MyScreen.homePageFontSize(context),
                onPress: () {
                  print("123");
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
                'PING',
                style: TextStyle(fontSize: MyScreen.homePageFontSize(context)),
              ),
              onPressed: () {
                print(123);
              },
            )),
            ButtonTheme(
              minWidth: MyScreen.homePageBarButtonWidth(context),
              child: new MyToolButton(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                text: "設定",
                textColor: Colors.white,
                color: Colors.transparent,
                fontSize: MyScreen.homePageFontSize(context),
                onPress: () {
                  print("123");
                },
              ),
            ),
            ButtonTheme(
              minWidth: MyScreen.homePageBarButtonWidth(context),
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
