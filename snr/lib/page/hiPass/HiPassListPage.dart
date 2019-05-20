
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/dao/HiPassDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';
import 'package:snr/widget/MyListState.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * 鎖hp list頁面
 * Date: 2019-04-30
 */
class HiPassListPage extends StatefulWidget {
  @override
  _HiPassListPageState createState() => _HiPassListPageState();
}

class _HiPassListPageState extends State<HiPassListPage> with AutomaticKeepAliveClientMixin<HiPassListPage>, MyListState<HiPassListPage> {
  ///data 相關
  Map<String, dynamic> typeArray = new Map<String, dynamic>();
  Map<String, dynamic> areaArray = new Map<String, dynamic>();
  List<dynamic> buildingArray = new List<dynamic>();
  @override
  bool get isRefreshFirst => false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      getApiDataList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  listHeight(){
    var height = super.listHeight();
    return height * 0.8;
  }
  getApiDataList() async{
    var res = await HiPassDao.getHiBuildAnalys();
    if(res != null && res.result) {
      setState(() {
        typeArray = res.data["Type"];
        areaArray = res.data["Area"];
        buildingArray = res.data["Building"];
        isLoading = false;
      });
    }
    else{
      isLoading = false;
    }
  }
  ///hp title
  Widget _buildHpTitle() {
    var hpDic;
    var lowhpDic;
    var pipeDic;
    var extraTotal = 0;
    var intraTotal = 0;
    var countTotal = 0;
    if (typeArray.length > 0) {
        hpDic = typeArray["HP"];
        extraTotal += int.parse(hpDic["EXT"]);
        intraTotal += int.parse(hpDic["INT"]);
        countTotal += int.parse(hpDic["TOTAL"]);
        lowhpDic = typeArray["LOWHP"];
        extraTotal += int.parse(lowhpDic["EXT"]);
        intraTotal += int.parse(lowhpDic["INT"]);
        countTotal += int.parse(lowhpDic["TOTAL"]);
        pipeDic = typeArray["PIPE"];
        extraTotal += int.parse(pipeDic["EXT"]);
        intraTotal += int.parse(pipeDic["INT"]);
        countTotal += int.parse(pipeDic["TOTAL"]);
    }
    return Column(
      children: <Widget>[
        Container(
          color: Color(MyColors.hexFromStr('#fafff2')),
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: (deviceWidth6() * 2) - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_status, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_extranet, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_intranet, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_other, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize(CommonUtils.getLocale(context).text_total_s, Colors.black),
              ),
            ],
          ),
        ),
        buildLine(),
        Container(
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: (deviceWidth6() * 2) - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_hp, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(hpDic["EXT"], Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(hpDic["INT"], Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize(hpDic["TOTAL"], Colors.black),
              ),
            ],
          ),
        ),
        buildLine(),
        Container(
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: (deviceWidth6() * 2) - 1,
                child: autoTextSize(CommonUtils.getLocale(context).home_cmtsTitle_lhp, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(lowhpDic["EXT"], Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(lowhpDic["INT"], Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize(lowhpDic["TOTAL"], Colors.black),
              ),
            ],
          ),
        ),
        buildLine(),
        Container(
          color: Color(MyColors.hexFromStr('#f2f2f2')),
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: (deviceWidth6() * 2) - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_pipeA, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(pipeDic["EXT"], Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(pipeDic["INT"], Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize(pipeDic["TOTAL"], Colors.black),
              ),
            ],
          ),
        ),
        buildLine(),
        Container(
          color: Color(MyColors.hexFromStr('#f2f2f2')),
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: (deviceWidth6() * 2) - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_noFix, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize('', Colors.black),
              ),
            ],
          ),
        ),
        buildLine(),
        Container(
          color: Color(MyColors.hexFromStr('#f0fcff')),
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: (deviceWidth6() * 2) - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_total, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('$extraTotal', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('$intraTotal', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize('$countTotal', Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
  ///區域hp
  Widget _buildHpArea() {
    var hpTotal = 0;
    var lowhpTotal = 0;
    var pipeTotal = 0;
    var countTotal = 0;
    if(areaArray.length > 0) {
      var keys = areaArray.keys.toList();
      for (var i = 0; i < areaArray.length; i++) {
        var val = areaArray[keys[i]];
        hpTotal += int.parse(val["HP"]);
        lowhpTotal += int.parse(val["LOWHP"]);
        pipeTotal += int.parse(val["PIPE"]);
        countTotal += int.parse(val["TOTAL"]);
      }
      
    }
    return Column(
      children: <Widget>[
        Container(
          color: Color(MyColors.hexFromStr('#fef5f6')),
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_status, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_hp, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).home_cmtsTitle_lhp, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_pipeA, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_noFix, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize(CommonUtils.getLocale(context).text_total_s, Colors.black),
              ),
            ],
          ),
        ),
        buildLine(),
        _buildHpAreaListView(),
        buildLine(),
        Container(
          color: Color(MyColors.hexFromStr('#f0fcff')),
          height: listHeight(),
          child: Row(
            children: <Widget>[
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize(CommonUtils.getLocale(context).text_total, Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('$hpTotal', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('$lowhpTotal', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('$pipeTotal', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6() - 1,
                child: autoTextSize('', Colors.black),
              ),
              buildLineHeight(),
              Container(
                width: deviceWidth6(),
                child: autoTextSize('$countTotal', Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
  ///hp區域item
  Widget _buildHpAreaItem(BuildContext context, int index) {
    var keys = areaArray.keys.toList();
    var val = areaArray[keys[index]];
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey,style: BorderStyle.solid))),
      height: listHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(keys[index], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(val["HP"], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(val["LOWHP"], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize(val["PIPE"], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6() - 1,
            child: autoTextSize('', Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth6(),
            child: autoTextSize(val["TOTAL"], Colors.black),
          ),
        ],
      ),
    );
  }
  ///hp區域list
  Widget _buildHpAreaListView(){
    Widget list;
    if(areaArray.length > 0) {
      list = Container(
        height: listHeight() * 5,
        child: ListView.builder(
          itemBuilder: _buildHpAreaItem,
          itemCount: areaArray.length,
        ),
      );
    }
    else {
      list = Container(child: buildEmpty(),);
    }
    return list;
  }
  ///點擊有效區域
  _renderTapArea() {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          _buildHpTitle(),
          buildLineRed(),
          _buildHpArea(),
          buildLineRed(),
        ],
      ),
      onTap: (){
        NavigatorUtils.goHiPassDetail(context);
      },
    );
  }
  ///大樓 title
  Widget _buildBuildingTitle() {
    return Container(
      decoration: BoxDecoration(color: Color(MyColors.hexFromStr('#ffffe4')), border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey,style: BorderStyle.solid))),
      height: listHeight(),
      child: Row(
        children: <Widget>[
          Container(
            width: (deviceWidth9() * 4) - 1,
            child: autoTextSize(CommonUtils.getLocale(context).text_buildingName, Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                autoTextSize(CommonUtils.getLocale(context).text_hp, Colors.black),
              ],
            )
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                autoTextSize(CommonUtils.getLocale(context).home_cmtsTitle_lhp, Colors.black),
              ],
            )
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                autoTextSize(CommonUtils.getLocale(context).text_pipeA, Colors.black),
              ],
            )
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                autoTextSize(CommonUtils.getLocale(context).text_noFix, Colors.black),
              ],
            )
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                autoTextSize(CommonUtils.getLocale(context).text_total_s, Colors.black),
              ],
            )
          ),
        ],
      ),
    );
  }
  ///大樓 item
  Widget _buildBuildingItem(BuildContext context, int index) {
    var dic = buildingArray[index];
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0,color: Colors.grey,style: BorderStyle.solid))),
      height: listHeight(),
      child: Row(
        children: <Widget>[
          Container(
            width: (deviceWidth9() * 4) - 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                 autoTextSize(dic["BuildingName"], Colors.black),
              ],
            ),
            
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: autoTextSize(dic["HP"], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: autoTextSize(dic["LHP"], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: autoTextSize(dic["PIPE"], Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9() - 1,
            child: autoTextSize('', Colors.black),
          ),
          buildLineHeight(),
          Container(
            width: deviceWidth9(),
            child: autoTextSize(dic["TOTAL"], Colors.black),
          ),
        ],
      ),
    );
  }
  ///大樓listview
  Widget _buildBuildingListView() {
    Widget list;
    if(buildingArray.length > 0) {
      list = Expanded(
        child: ListView.builder(
          itemBuilder: _buildBuildingItem,
          itemCount: buildingArray.length,
        ),
      );
    }
    else {
      list = Container(child: buildEmpty(),);
    }
    return list;
  }
  ///body
  Widget getBody() {
    Widget body;
    if(isLoading) {
      body = showLoadingAnime(context);
    }
    else {
      body = Column(
        children: <Widget>[
          _renderTapArea(),
          _buildBuildingTitle(),
          _buildBuildingListView()
        ],
      );
    }
    return body;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: MyScreen.homePageBarButtonWidth(context),
                    child: new MyToolButton(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      text: CommonUtils.getLocale(context).text_hp,
                      textColor: Colors.white,
                      color: Colors.transparent,
                      fontSize: MyScreen.normalPageFontSize(context),
                      onPress: () {
                  
                      },
                    ),
                  ),
                  // SizedBox(),
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
                      style: TextStyle(
                          fontSize: MyScreen.normalPageFontSize(context)),
                    ),
                    onPressed: () {
                      print(123);
                    },
                  )),
                  Text('資料:',
                      style: TextStyle(
                          fontSize: MyScreen.normalPageFontSize(context),
                          color: Colors.white)
                  ),
                  SizedBox(),
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
                  text: CommonUtils.getLocale(context).text_refresh,
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
                      Fluttertoast.showToast(
                          msg: CommonUtils.getLocale(context).loading_text);
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
      )
    );
  }
}