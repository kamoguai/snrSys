
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * 大PING裡面的CPE dialog
 * Date: 2019-05-08
 */
class CPEDialog extends StatelessWidget {

  final String custNo;
  final String custName;
  final List<dynamic> data;

  CPEDialog(this.custNo, this.custName, this.data);

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  _buildLineHeight(context) {
    return Container(
      height: _listHeight(context),
      width: 1.0,
      color: Colors.grey,
    );
  }

  _deviceWidth2(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return (deviceWidth / 2);
  }

  ///取得裝置height切4分
  _deviceHeight4(BuildContext context) {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  _listHeight(BuildContext context) {
    var height = _deviceHeight4(context);
    return height / 5;
  }

  ///title height
  _titleHeight(BuildContext context) {
    var height = _deviceHeight4(context);
    return height / 4;
  }
  
  ///字體自動縮放
  _autoTextSize(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }
  Widget _cpeItem(BuildContext context, int index) {
    var dic = data[index];
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
      height: _listHeight(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0),
            width: _deviceWidth2(context) - 5,
            child: _autoTextSize(dic["IP"], TextStyle(color: Colors.black), context),
          ),
          _buildLineHeight(context),
          Container(
            padding: EdgeInsets.only(left: 5.0),
            width: _deviceWidth2(context) - 5,
            child: _autoTextSize(dic["MAC"], TextStyle(color: Colors.black), context),
          )
        ],
      ),
    );
  }
  Widget _cpeListView() {
    Widget listView;
    if(data.length > 0) {
      listView = Container(
        height: 200,
        child: ListView.builder(
          itemBuilder: _cpeItem,
          itemCount: data.length,
        ),
      );
    }
    else {
      listView = Center(child: Text('尚無資料'),);
    }
    return listView;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(MyColors.hexFromStr('#f0fcff')),
      child: Column(
        children: <Widget>[
          Container(
            height: _listHeight(context),
            padding: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  child: _autoTextSize('客編: ', TextStyle(color: Colors.black), context),
                ),
                Container(
                  child: _autoTextSize(custNo, TextStyle(color: Colors.black), context),
                ),
                SizedBox(width: 10.0,),
                Container(
                  child: _autoTextSize('姓名: ', TextStyle(color: Colors.black), context),
                ),
                Container(
                  child: _autoTextSize(custName, TextStyle(color: Colors.black), context),
                ),
              ],
            ),
          ),
          _cpeListView(),
          _buildLine(),
          Container(
            height: _titleHeight(context),
            child: FlatButton(
              textColor: Colors.red,
              child: Text('離開', style: TextStyle(fontSize: MyScreen.appBarFontSize(context)),),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}