

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/model/FinishedTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';

/**
 * 完工用table cell
 * 2019-04-19
 */
class FinishedTableItem extends StatelessWidget {

  final FinishedViewModel defaultViewModel;
  final String nowType;

  FinishedTableItem({this.defaultViewModel, this.nowType});
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

  _buildHeightLine() {
    return new Container(
      height: 25.0,
      width: 1.0,
      color: Colors.grey,
    );
  }

  _deviceWidth3(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 3;
  }

  _deviceWidth9(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 9;
  }

  _deviceWidth15(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 15;
  }
  _deviceWidth92(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    var width9 =  deviceWidth / 9;
    return (width9 * 2) + (width9 * 0.5);
  }

  Widget _autoTextSize(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

    Widget _autoTextSizeLeft(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.left,
    );
  }

  _autoContainer({child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
        )
      ),
      child: child,
    );
  }

  _autoContainer_full({child}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
        border: Border(
        )
      ),
      child: child,
    );
  }

  Widget centerLayout(BuildContext context) {
    Widget layout;
    switch(nowType) {
      case "bigbad":
        layout = Container();
        break;
      default:
        layout = Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
          child: Row(
            children: <Widget>[
              Container(
                width: _deviceWidth3(context) - 1,
                child: _autoTextSize(
                    defaultViewModel.custNo, TextStyle(color: Colors.grey), context),
              ),
              _buildHeightLine(),
              Container(
                width: (_deviceWidth3(context) + _deviceWidth9(context) * 0.5) - 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Color(MyColors.hexFromStr('#f0fcff')),
                      width: (_deviceWidth9(context) / 2) - 1,
                      child: _autoTextSize(
                          defaultViewModel.note1, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note1_color))), context),
                    ),
                    _buildHeightLine(),
                    Container(
                      width: _deviceWidth3(context) - 1,
                      child: _autoTextSize(
                          defaultViewModel.custClass, TextStyle(color: Colors.red), context),
                    ),
                  ],
                ),
              ),
              _buildHeightLine(),
              Container(
                  width: _deviceWidth92(context),
                  child: Container(
                    child: _autoTextSize(
                        defaultViewModel.name, TextStyle(color: Colors.black), context),
                  )),
            ],
          ),
        );
    }
    return layout;
  }

  Widget bottomLayout(BuildContext context) {
    Widget layout;
    switch(nowType) {
      case "finished": 
        layout = _autoContainer(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finish + defaultViewModel.finishedTime, TextStyle(color: Colors.black), context),
              ),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_fix2 + defaultViewModel.finishedTime, TextStyle(color: Colors.pink), context),
              ),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context),
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finish + defaultViewModel.finishedTime, TextStyle(color: Colors.pink), context),
              ),
            ],
          )
        );
        break;
      case "bp":
        layout = _autoContainer(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finish + defaultViewModel.finishedTime, TextStyle(color: Colors.black), context),
              ),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_fix2 + defaultViewModel.finishedTime, TextStyle(color: Colors.pink), context),
              ),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context),
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finalFinished + defaultViewModel.finishedTime, TextStyle(color: Colors.purple), context),
              ),
            ],
          )
        );
        break;
      case "bigbad":
        layout = _autoContainer(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: (_deviceWidth15(context) * 5) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_sendReoprt + defaultViewModel.finishedTime, TextStyle(color: Colors.pink), context),
              ),
              _buildHeightLine(),
              SizedBox(width: _deviceWidth15(context) - 1),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: (_deviceWidth15(context) * 5) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finish + defaultViewModel.finishedTime, TextStyle(color: Colors.blue), context),
              ),
              _buildHeightLine(),
              SizedBox(width: _deviceWidth15(context) - 1),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth15(context) * 3,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_spendTime + ":" + defaultViewModel.finishedTime, TextStyle(color: Colors.black), context),
              ),
            ],
          )
        );
        break;
      case "pipe":
        layout = _autoContainer(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finish + defaultViewModel.finishedTime, TextStyle(color: Colors.black), context),
              ),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context) - 1,
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_fix2 + defaultViewModel.finishedTime, TextStyle(color: Colors.pink), context),
              ),
              _buildHeightLine(),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                width: _deviceWidth3(context),
                child: _autoTextSizeLeft(CommonUtils.getLocale(context).text_finish + defaultViewModel.finishedTime, TextStyle(color: Colors.pink), context),
              ),
            ],
          )
        );
        break;
    }
    return layout;
  }

  @override
  Widget build(BuildContext context) {
    var netType = 'EXT';
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 2.0, bottom: 2.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(border: Border()),
            child: _autoTextSizeLeft(defaultViewModel.address,TextStyle(color: Colors.grey[700]), context)
          ),
          _buildLine(),
          centerLayout(context),
          bottomLayout(context),
          _buildLine(),
          GestureDetector(
            child: Container(
              child: _autoContainer_full(
                child: _autoTextSize(defaultViewModel.reportLog, TextStyle(color:  Color(MyColors.hexFromStr(defaultViewModel.reportLogColor))), context),
              ),
            ),
            onTap: (){print("showLog");},
          ),
          _buildRedLine()
        ],
      ),
    );
  }
}
class FinishedViewModel {
  String address;
  String custNo;
  String note1;
  String note1_color;
  String custClass;
  String name;
  String finishedTime;
  String fix2Time;
  String finishedTime2;
  String reportLog;
  String reportLogColor;

  FinishedViewModel();

  FinishedViewModel.forMap(FinishedTableCell data) {
    address = data.Address == null ? "" : data.Address;
    custNo = data.CustNo == null ? "" : data.CustNo;
    note1 = data.note1 == null ? "" : data.note1;
    note1_color = data.note1_color == null ? "000000" : data.note1_color;
    custClass = data.CustClass == null ? "" : data.CustClass;
    name = data.Name == null ? "" : data.Name;
    finishedTime = data.FinishedTime == null ? "" : data.FinishedTime;
    fix2Time = data.Fix2Time == null ? "" : data.Fix2Time;
    finishedTime2 = data.FinishedTime2 == null ? "" : data.FinishedTime2;
    reportLog = data.ReportLog == null ? "" : data.ReportLog;
    reportLogColor = data.ReportLogColor == null ? "000000" : data.ReportLogColor;
    
  }
}