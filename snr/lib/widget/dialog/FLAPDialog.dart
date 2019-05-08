
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * FLAP dialog
 * Date: 2019-05-08
 */
class FLAPDialog extends StatelessWidget {
  final String custNo;
  final String custName;
  final Map<String,dynamic> data;
  final FlapViewModel defaultViewModel;
  final Function clearFlapFunc;
  FLAPDialog({this.custNo, this.custName, this.data, this.defaultViewModel, this.clearFlapFunc});

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  _buildRedLine() {
    return new Container(
      height: 1.0,
      color: Colors.red,
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
    return (deviceWidth / 2) - 4;
  }

  _deviceWidth5(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return (deviceWidth / 5) - 4;
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
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(MyColors.hexFromStr('#fdfff7')),
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
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('U0', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('U1', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('U2', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context),
                  child: _autoTextSize('U3', TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('Ins', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0I, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1I, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2I, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3I, TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('Hit', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0H, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1H, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2H, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3H, TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('Miss', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0M, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1M, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2M, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3M, TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('CRC', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0C, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1C, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2C, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3C, TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('P-Adj', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0P, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1P, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2P, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3P, TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('Flap', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0F, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1F, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2F, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3F, TextStyle(color: Colors.black), context),
                ),
                
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize('Time', TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u0T, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u1T, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) - 1,
                  child: _autoTextSize(defaultViewModel.u2T, TextStyle(color: Colors.black), context),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth5(context) ,
                  child: _autoTextSize(defaultViewModel.u3T, TextStyle(color: Colors.black), context),
                ),
               
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5.0),
            height: _listHeight(context),
            child: _autoTextSize('清除記錄： ', TextStyle(color: Colors.black), context),
          ),
          _buildLine(),
          Container(
            height: _titleHeight(context),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth2(context) - 1,
                  child: FlatButton(
                    textColor: Colors.red,
                    child: Text('清除', style: TextStyle(fontSize: MyScreen.appBarFontSize(context)),),
                    onPressed: (){
                      clearFlapFunc();
                    },
                  ),
                ),
                _buildLineHeight(context),
                Container(
                  width: _deviceWidth2(context),
                  child: FlatButton(
                    textColor: Colors.black,
                    child: Text('離開', style: TextStyle(fontSize: MyScreen.appBarFontSize(context)),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
            
          )
        ],
      ),
    );
  }
}

class FlapViewModel {
  Map<String,dynamic> uMap = new Map<String,dynamic>();
  String u0I;
  String u0H;
  String u0M;
  String u0C;
  String u0P;
  String u0F;
  String u0T;
  String u0Line;
  String u1I;
  String u1H;
  String u1M;
  String u1C;
  String u1P;
  String u1F;
  String u1T;
  String u1Line;
  String u2I;
  String u2H;
  String u2M;
  String u2C;
  String u2P;
  String u2F;
  String u2T;
  String u2Line;
  String u3I;
  String u3H;
  String u3M;
  String u3C;
  String u3P;
  String u3F;
  String u3T;
  String u3Line;

  FlapViewModel();

  FlapViewModel.forMap(data) {
    uMap = data["U0"] == null ? null : data["U0"];
    u0I = uMap["I"];
    u0H = uMap["H"];
    u0M = uMap["M"];
    u0C = uMap["C"];
    u0P = uMap["P"];
    u0F = uMap["F"];
    u0T = uMap["T"];
    u0Line = uMap["LINE"];
    uMap = data["U1"] == null ? null : data["U1"];
    u1I = uMap["I"];
    u1H = uMap["H"];
    u1M = uMap["M"];
    u1C = uMap["C"];
    u1P = uMap["P"];
    u1F = uMap["F"];
    u1T = uMap["T"];
    u1Line = uMap["LINE"];
    uMap = data["U2"] == null ? null : data["U2"];
    u2I = uMap["I"];
    u2H = uMap["H"];
    u2M = uMap["M"];
    u2C = uMap["C"];
    u2P = uMap["P"];
    u2F = uMap["F"];
    u2T = uMap["T"];
    u2Line = uMap["LINE"];
    uMap = data["U3"] == null ? null : data["U3"];
    u3I = uMap["I"];
    u3H = uMap["H"];
    u3M = uMap["M"];
    u3C = uMap["C"];
    u3P = uMap["P"];
    u3F = uMap["F"];
    u3T = uMap["T"];
    u3Line = uMap["LINE"];
    
  }
}