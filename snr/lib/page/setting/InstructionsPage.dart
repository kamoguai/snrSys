
import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/page/setting/InstructionsDetailPage.dart';
import 'package:snr/page/setting/JumpSettingPage.dart';
import 'package:snr/page/setting/ParamSettingPage.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/SettingTabBarWidget.dart';

/**
 * 操作說明頁面
 * Date: 2019-05-02
 */
class InstructionsPage extends StatefulWidget {
  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  ///取得裝置width並切6份
  deviceWidth3(context) {
    var width = MediaQuery.of(context).size.width;
    return width / 3;
  }
  ///app bar actions
  _renderAppBarAction(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: deviceWidth3(context),
            child: Text(CommonUtils.getLocale(context).text_settingPage, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: MyScreen.appBarFontSize(context)),),
          ),
          Container(
            alignment: Alignment.center,
            width: deviceWidth3(context),
            child: FlatButton.icon(
              icon: Image.asset(
                MyICons.DEFAULT_USER_ICON,
                width: 30,
                height: 30,
              ),
              textColor: Colors.white,
              color: Colors.transparent,
              label: Text(
                'DCTV',
                style: TextStyle(
                    fontSize: MyScreen.normalPageFontSize_s(context)),
              ),
              onPressed: () {
                print(123);
              },
            )
          ),
          Container(
            width: deviceWidth3(context),
            child: MyToolButton(
              text: '',
              textColor: Colors.white,
              fontSize: MyScreen.appBarFontSize(context),
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              onPress: (){
              
              },
            ),
          ),
        ],
      ),
    );
  }
  ///body的tab按鈕
  _renderTab(text, colorStr, context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(color: Color(MyColors.hexFromStr(colorStr)) ,border: Border.all(width: 1.0,style: BorderStyle.solid,color: Colors.grey), borderRadius: BorderRadius.circular(10.0)),
        alignment: Alignment.center,
        
        child: Text(text, style: TextStyle(fontSize: MyScreen.normalListPageFontSize(context)),),
      ),
    );
  }
  ///bottomNavBar item
  _renderBottomItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: CommonUtils.getLocale(context).common_toolBar_set,
            textColor: Colors.white,
            color: Colors.transparent,
            fontSize: MyScreen.homePageFontSize(context),
            onPress: () {
              
            },
          ),
        ),
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: CommonUtils.getLocale(context).text_standar,
            textColor: Colors.white,
            color: Colors.transparent,
            fontSize: MyScreen.homePageFontSize(context),
            onPress: () {
              NavigatorUtils.goStandard(context);
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
            style: TextStyle(
                fontSize: MyScreen.homePageFontSize(context)),
          ),
          onPressed: () {
            print(123);
          },
        )),
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: '',
            textColor: Colors.white,
            color: Colors.transparent,
            fontSize: MyScreen.homePageFontSize(context),
            onPress: () {
              
            },
          ),
        ),
        ButtonTheme(
          minWidth: MyScreen.homePageBarButtonWidth(context),
          child: new MyToolButton(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            text: CommonUtils.getLocale(context).text_back,
            textColor: Colors.white,
            color: Colors.transparent,
            fontSize: MyScreen.homePageFontSize(context),
            mainAxisAlignment: MainAxisAlignment.start,
            onPress: () {
              print('it click');
              Navigator.pop(context);          
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(CommonUtils.getLocale(context).text_intructions, '#e8fcff',context),
      _renderTab(CommonUtils.getLocale(context).text_jumpSetting, '#fef0ed',context),
      _renderTab(CommonUtils.getLocale(context).text_paramSetting, '#fff7dc',context),
    ];
    return SettingTabBarWidget(
      appBarActions: _renderAppBarAction(context),
      tabItems: tabs,
      tabViews: [
        InstructionsDetailPage(),
        JumpSettingPage(),
        ParamSettingPage(),
      ],
      backgroundColor: MyColors.primarySwatch,
      indicatorColor: Colors.transparent,
      bottomNavBarChild: _renderBottomItem(context),
    );
  }
}
