

import 'package:flutter/material.dart';
import 'package:snr/widget/MyTabBarWidget.dart';

class SettingTabBarWidget extends StatefulWidget {

  final int type;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Widget appBarActions;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget floatingActionButton;

  final TarWidgetControl tarWidgetControl;

  final PageController topPageControl;

  final ValueChanged<int> onPageChanged;

  final Widget bottomNavBarChild;

  final Widget getBody;
  
  SettingTabBarWidget({
    Key key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.appBarActions,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.floatingActionButton,
    this.tarWidgetControl,
    this.topPageControl,
    this.onPageChanged,
    this.bottomNavBarChild,
    this.getBody,
  }) : super(key: key);

  @override
  _SettingTabBarState createState() => new _SettingTabBarState(
    type,
    tabViews,
    appBarActions,
    indicatorColor,
    title,
    floatingActionButton,
    tarWidgetControl,
    topPageControl,
    onPageChanged,
    bottomNavBarChild,
    getBody,
  );
}

class _SettingTabBarState extends State<SettingTabBarWidget> with SingleTickerProviderStateMixin {

  final int _type;

  final List<Widget> _tabViews;

  final Widget _appBarActions;

  final Color _indicatorColor;

  final Widget _title;

  final Widget _floatingActionButton;

  final TarWidgetControl _tarWidgetControl;

  final PageController _pageController;

  final ValueChanged<int> _onPageChanged;

  final Widget _bottomNavBarChild;

  final Widget _getBody;

  _SettingTabBarState(
    this._type,
    this._tabViews,
    this._appBarActions,
    this._indicatorColor,
    this._title,
    this._floatingActionButton,
    this._tarWidgetControl,
    this._pageController,
    this._onPageChanged,
    this._bottomNavBarChild,
    this._getBody,
    ) : super();

    TabController _tabController;

  ///取得裝置width並切6份
  deviceWidth3() {
    var width = MediaQuery.of(context).size.width;
    return width / 3;
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return new SafeArea(
      top: false,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: Container(),
          elevation: 0.0,
          actions: <Widget>[
            _appBarActions
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 50),
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0,),
              child: TabBar(
                labelColor: Colors.grey[700],
                controller: _tabController, //配置控制器
                tabs: widget.tabItems,
                indicatorColor: _indicatorColor, //tab标签的下划线颜色
              ),
            ),
            Container(color: Colors.grey, height: 1.0,),
            SizedBox(height: 5.0,),
            Expanded(
              child: Container(
                child: TabBarView(
                  //TabBarView呈现内容，因此放到Scaffold的body中
                  controller: _tabController, //配置控制器
                  children: _tabViews
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: new Material(
          //为了适配主题风格，包一层Material实现风格套用
          color: Theme.of(context).primaryColor, //底部导航栏主题颜色
          child: _bottomNavBarChild
        )
      )
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
