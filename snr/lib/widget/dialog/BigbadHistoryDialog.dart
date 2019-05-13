
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/MyListState.dart';

/**
 * 重大異常歷史dialog
 * Date: 2019-04-25
 */
class BigBadHistoryDialog extends StatefulWidget {
  @override
  _BigBadHistoryDialogState createState() => _BigBadHistoryDialogState();
}

class _BigBadHistoryDialogState extends State<BigBadHistoryDialog> with AutomaticKeepAliveClientMixin<BigBadHistoryDialog>, MyListState<BigBadHistoryDialog> {

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
  ///初始化數據
  initData() {
    dataArray = [];
   
  }
  ///取得api data
  getApiDataList() async {
    initData();
    isLoading = false;
  }
  

  ///title height
  @override
  titleHeight() {
    var height = deviceHeight4();
    return height / 4.8;
  }
  
  ///字體自動縮放
  @override
  autoTextSize(text, style) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  ///title
  Widget _buildTitle(context) {
    return Container(
      height: titleHeight(),
      color: Color(MyColors.hexFromStr('#fafff2')),
      child: Row(
        children: <Widget>[
          autoTextSize('cmts+node', TextStyle(color: Colors.black) )
        ],
      ),
    );
  }
  ///內容
  Widget _buildHistoryBody(context, {index}) {
    var value;
    if (index != null) {
      value = index;
    }
    Widget body;
    body = GestureDetector(
      child: Container(
        color: Color(MyColors.hexFromStr('#f0fcff')),
        child: Column(
          children: <Widget>[
            Container(
              height: listHeight(),
              child: ListView(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  autoTextSize("查修時間:", TextStyle(color: Colors.black) ),
                  autoTextSize("起日", TextStyle(color: Colors.red) ),
                  SizedBox(width: 5.0,),
                  autoTextSize("起時", TextStyle(color: Colors.red) ),
                  autoTextSize("~", TextStyle(color: Colors.black) ),
                  autoTextSize("迄日", TextStyle(color: Colors.blue) ),
                  SizedBox(width: 5.0,),
                  autoTextSize("迄時", TextStyle(color: Colors.blue) ),
                  SizedBox(width: 5.0,),
                  autoTextSize("耗時: ", TextStyle(color: Colors.black) ),
                ],
              ),
            ),
            buildLine(),
            Container(
              height: listHeight() * 1.5,
              child: ListView(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  autoTextSize('查修原因: ', TextStyle(color: Colors.black) )
                ],
              ),
            ),
            buildLine(),
            Container(
              height: listHeight() * 2,
              child: ListView(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  autoTextSize('查修說明: ', TextStyle(color: Colors.black) )
                ],
              ),
            ),
            buildLine(),
            Container(
              height: listHeight(),
              child: ListView(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  autoTextSize('立案人: ', TextStyle(color: Colors.black) ),
                  autoTextSize('x先生: ', TextStyle(color: Colors.black) ),
                  SizedBox(width: 10.0,),
                  autoTextSize('查修人: ', TextStyle(color: Colors.black) ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        Fluttertoast.showToast(msg: '選擇該筆資料');
      },
    );
    return body;
  }
  ///item 
  Widget _buildItem(BuildContext context, int index) {
    
    Widget item;
    item = _buildHistoryBody(context, index: index);
    return item;
  }
  ///list
  Widget _buildList() {
    Widget list;
    if(dataArray.length > 0) {
      list = Expanded(
        child: ListView.builder(
          itemBuilder: _buildItem,
          itemCount: dataArray.length,
        ),
      );
    }
    else {
      list = Container(child: buildEmpty(),);
    }
    return list;
  }
  ///button event
  _buildButton() {
    return Container(
      color: Color(MyColors.hexFromStr('#fafff2')),
      height: titleHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: FlatButton(
              child: autoTextSize('刪除', TextStyle(color: Colors.red) ),
              onPressed: (){},
            ),
          ),
          buildLineHeight(),
           Container(
            child: FlatButton(
              child: autoTextSize('離開', TextStyle(color: Colors.black) ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget build;
    build = Container(
      
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          buildLine(),
          _buildHistoryBody(context),
          buildLineRed(),
          _buildList(),
          buildLine(),
          _buildButton()
        ],
      ),
    );
    return build;
  }
}
