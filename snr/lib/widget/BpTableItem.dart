

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/model/BpTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
/**
 * 待確認，扣點tableItem
 * Data: 2019-04-29
 */
class BpTableItem extends StatelessWidget {
 
  final BpViewModel defaultViewModel;
  final bpType;
 
  BpTableItem({this.defaultViewModel,this.bpType});
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

  _buildHeight() {
    return 25.0;
  }


  _deviceWidth10(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 10;
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
  Widget _container({child, width, height, color}) {

    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(width: 1.0,style: BorderStyle.solid,color: Colors.grey)
        )
      ),
      height: height == null ? 30.0 : height,
      width: width,
      child: child,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var lastWidget;
    if (bpType == "confirm") {
      lastWidget = Container(
        decoration: BoxDecoration(border: Border()),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: _autoTextSizeLeft('待確認說明: ', TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.reportLogColor))), context),
      );
    }
    else {
      lastWidget = Container(
        decoration: BoxDecoration(border: Border()),
        height: _buildHeight(),
        child: Row(
          children: <Widget>[
            Container(
              width: _deviceWidth10(context) - 1,
              child: _autoTextSize(CommonUtils.getLocale(context).text_bp, TextStyle(color: Colors.black), context),
            ),
            _buildHeightLine(),
            Container(
              width: _deviceWidth10(context) - 1,
              child: _autoTextSize('N點', TextStyle(color: Colors.red), context),
            ),
            _buildHeightLine(),
            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 2.0),
                      child: _autoTextSize('扣點說明: ', TextStyle(color: Colors.grey), context),
                    )
                  ],
                )
              ),
            )
          ],
        )
      );
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _container(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5.0,right: 5.0),
              children: <Widget>[
                _autoTextSize(defaultViewModel.address, TextStyle(color: Colors.grey,), context)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border()),
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth10(context) * 3) - 1,
                  child: _autoTextSize(defaultViewModel.installMan, TextStyle(color: Colors.grey), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth10(context) * 4) - 1,
                  child: _autoTextSize(defaultViewModel.installDate, TextStyle(color: Colors.grey), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth10(context) * 3,
                  child: _autoTextSize(defaultViewModel.saleMan, TextStyle(color: Colors.grey), context),
                ),
              ],
            )
          ),
          _buildLine(),
          Container(
            decoration: BoxDecoration(border: Border()),
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth10(context) * 3) - 1,
                  child: _autoTextSize(defaultViewModel.realNodePath, TextStyle(color: Colors.red), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth10(context) * 4) - 1,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: (_deviceWidth10(context) * 1.5) - 1,
                        child: _autoTextSize(defaultViewModel.note6, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note6_color))), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth10(context) * 2.5) - 1,
                        child: _autoTextSize(defaultViewModel.fixDate, TextStyle(color: Colors.brown), context),
                      ),
                    ],
                  ),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth10(context) * 2,
                  child: _autoTextSize(defaultViewModel.workMan, TextStyle(color: Colors.purple), context),
                )
              ],
            )
          ),
          _buildLine(),
          Container(
            decoration: BoxDecoration(border: Border()),
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth10(context) * 3) - 1,
                  child: _autoTextSize(defaultViewModel.realNodePath, TextStyle(color: Colors.grey), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth10(context) * 4) - 1,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        color: Colors.blue[100],
                        width: _deviceWidth10(context) - 1,
                        child: _autoTextSize('', TextStyle(color: Colors.red), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth10(context) * 3) - 1,
                        child: _autoTextSize(defaultViewModel.custClass, TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth10(context) * 3,
                  child: _autoTextSize(defaultViewModel.name, TextStyle(color: Colors.black), context),
                )
              ],
            )
          ),
          _buildLine(),
          Container(
           
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: _autoTextSizeLeft('BOSS: ${defaultViewModel.bossLog}', TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.bossLogColor))), context),
          ),
          _buildLine(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: _autoTextSizeLeft('維修記錄: ${defaultViewModel.reportLog}', TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.reportLogColor))), context),
          ),
          _buildLine(),
          lastWidget,
          _buildRedLine()
        ],
      ),
    );
  }
}

class BpViewModel {
  String name;//客戶名
  String custNo;//客編
  String n_COID;//工單號
  String address;//地址
  String installMan;//安裝人員
  String installDate;//安裝時間
  String saleMan;//業務人員
  String note6;//note6
  String note6_color;//note6 color
  String note7;//note7
  String target;
  String yearMonth;//資料年份
  String workDate;//實作日期
  String workInfo;//實作信息
  String workMan;//實作人員
  String fixDate;//維修時間
  String building;//大樓名稱
  String custClass;//大樓名稱
  String reportLog;//工程回報
  String reportLogColor;//工程回報color
  String bossLog;//boss信息
  String bossLogColor;//boss color
  String realNodePath;//真實路徑
  String bossNodePath;//boss路徑

  BpViewModel();

  BpViewModel.forMap(BpTableCell data) {
    name = data.Name == null ? "" : data.Name;
    custNo = data.CustNo == null ? "" : data.CustNo;
    n_COID = data.N_COID == null ? "" : data.N_COID;
    address = data.Address == null ? "" : data.Address;
    installMan = data.InstallMan == null ? "" : data.InstallMan;
    installDate = data.InstallDate == null ? "" : data.InstallDate;
    saleMan = data.SaleMan == null ? "" : data.SaleMan;
    note6 = data.note6 == null ? "" : data.note6;
    note6_color = data.note6_color == null ? "000000" : data.note6_color;
    note7 = data.note7 == null ? "" : data.note7;
    target = data.Target == null ? "" : data.Target;
    yearMonth = data.YearMonth == null ? "" : data.YearMonth;
    workDate = data.WorkDate == null ? "" : data.WorkDate;
    workInfo = data.WorkInfo == null ? "" : data.WorkInfo;
    workMan = data.WorkMan == null ? "" : data.WorkMan;
    fixDate = data.fixDate == null ? "" : data.fixDate;
    building = data.Building == null ? "" : data.Building;
    custClass = data.CustClass == null ? "" : data.CustClass;
    reportLog = data.ReportLog == null ? "" : data.ReportLog;
    reportLogColor = data.ReportLogColor == null ? "000000" : data.ReportLogColor;
    bossLog = data.BossLog == null ? "" : data.BossLog;
    bossLogColor = data.BossLogColor == null ? "000000" : data.BossLogColor;
    realNodePath = data.RealNodePath == null ? "" : data.RealNodePath;
    bossNodePath = data.BossNodePath == null ? "" : data.BossNodePath;
  }
}