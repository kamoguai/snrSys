import 'package:flutter/material.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:snr/common/style/MyStyle.dart';

/**
 * 通用table item
 * Date: 2019-04-02
 */
class DefaultTableItem extends StatelessWidget {
  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  _buildHeightLine() {
    return new Container(
      height: 25.0,
      width: 1.0,
      color: Colors.grey,
    );
  }

  _deviceWidth(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth;
  }

  _deviceWidth2(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 2;
  }

  _deviceWidth3(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 3;
  }

  _deviceWidth4(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 4;
  }

  _deviceWidth5(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 5;
  }

  _deviceWidth6(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth / 6;
  }

  _autoTextSize(text, style) {
    return AutoSizeText(
      text,
      style: style,
      maxFontSize: 16.0,
      minFontSize: 8.0,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildLine(),
                Container(
                    height: 25.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: () {},
                            child: _autoTextSize(
                              'address',
                              TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    )),
                _buildLine(),
                Container(
                  height: 25.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          child: Container(
                            child: _autoTextSize(
                                'installman', TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      _buildHeightLine(),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          child: Container(
                            child: _autoTextSize(
                                'installtime', TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      _buildHeightLine(),
                      Expanded(
                          child: FlatButton(
                        onPressed: () {},
                        child: Container(
                          child: _autoTextSize(
                              'saleman', TextStyle(color: Colors.grey)),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildLine(),
          Container(
            height: 25.0,
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: _deviceWidth4(context) * 1.27,
                  child: _autoTextSize(
                      'realNodePath', TextStyle(color: Colors.grey)),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth6(context) / 1.29,
                  child: _autoTextSize('note6', TextStyle(color: Colors.blue)),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth5(context),
                  child: _autoTextSize(
                      'maintainTime', TextStyle(color: Colors.brown)),
                ),
                _buildHeightLine(),
                Expanded(
                  child: FlatButton(
                      onPressed: () {
                        print('指派人員');
                      },
                      child: Container(
                        child: _autoTextSize(
                            'assignMan', TextStyle(color: Colors.brown)),
                      )),
                ),
              ],
            ),
          ),
          _buildLine(),
          Container(
            height: 25.0,
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth2(context) * 1.303,
                  child: _autoTextSize(
                      'bossNosePath', TextStyle(color: Colors.black)),
                ),
                _buildHeightLine(),
                Expanded(
                  child: Container(
                    child:
                        _autoTextSize('otime', TextStyle(color: Colors.blue)),
                  ),
                )
              ],
            ),
          ),
          _buildLine(),
          Container(
            height: 25.0,
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth4(context) * 1.27,
                  child:
                      _autoTextSize('custCode', TextStyle(color: Colors.grey)),
                ),
                _buildHeightLine(),
                Container(
                  color: Color(MyColors.hexFromStr('#f0fcff')),
                  width: _deviceWidth6(context) / 2.5,
                  child: _autoTextSize('note1', TextStyle(color: Colors.red)),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth4(context) * 1.048,
                  child:
                      _autoTextSize('buildName', TextStyle(color: Colors.red)),
                ),
                _buildHeightLine(),
                Expanded(
                    child: Container(
                  child: _autoTextSize('custName', TextStyle(color: Colors.black)),
                )),
              ],
            ),
          ),
          _buildLine(),
          Container(
            height: 25.0,
            
          )
        ],
      ),
    );
  }
}

class DefaultViewModel {
  String address;
  String installMan;
  String installDate;
  String saleMan;
  String realNodePath;
  String note6;
  String note6_color;
  String maintainTime;
  String assignMan;
  String bossNodePath;
  String otime;
  String custNo;
  String note1;
  String note1_color;
  String custClass;
  String name;
  String isMarjor;
  String restartCount;
  String restartTime;
  String u0_SNR;
  String u1_SNR;
  String u2_SNR;
  String u3_SNR;
  String u0_PWR;
  String u1_PWR;
  String u2_PWR;
  String u3_PWR;
  String ds0;
  String ds1;
  String ds2;
  String ds3;
  String ds4;
  String ds5;
  String ds6;
  String ds7;
  String dp0;
  String dp1;
  String dp2;
  String dp3;
  String dp4;
  String dp5;
  String dp6;
  String dp7;
  String status;
  String bb;
  String note2;
  String note2_color;
  String note3;
  String note3_color;
  String note4;
  String note4_color;
  String note5;
  String note5_color;
  String dataTime2;
  String usflow;
  String dsflow;
  String response;
  String packetLoss;
  String reportLog;
  String u0c;
  String u0u;
  String u1C;
  String u1u;
  String u2C;
  String u2u;
  String u3c;
  String u3u;

  DefaultViewModel();

  DefaultViewModel.forMap(DefaultTableCell data) {
    address = data.Address;
    installMan = data.InstallMan;
    installDate = data.InstallDate;
    saleMan = data.SaleMan;
    realNodePath = data.RealNodePath;
    note6 = data.note6;
    note6_color = data.note6_color;
    maintainTime = data.MaintainTime;
    assignMan = data.AssignMan;
    bossNodePath = data.BossNodePath;
    otime = data.OTIME;
    custNo = data.CustNo;
    note1 = data.note1;
    note1_color = data.note1_color;
    custClass = data.CustClass;
    name = data.Name;
    isMarjor = data.isMarjor;
    restartCount = data.RestartCount;
    restartTime = data.RestartTime;
    u0_SNR = data.U0_SNR;
    u1_SNR = data.U1_SNR;
    u2_SNR = data.U2_SNR;
    u3_SNR = data.U3_SNR;
    u0_PWR = data.U0_PWR;
    u1_PWR = data.U1_PWR;
    u2_PWR = data.U2_PWR;
    u3_PWR = data.U3_PWR;
    ds0 = data.DS0;
    ds1 = data.DS1;
    ds2 = data.DS2;
    ds3 = data.DS3;
    ds4 = data.DS4;
    ds5 = data.DS5;
    ds6 = data.DS6;
    ds7 = data.DS6;
    dp0 = data.DP0;
    dp1 = data.DP1;
    dp2 = data.DP2;
    dp3 = data.DP3;
    dp4 = data.DP4;
    dp5 = data.DP5;
    dp6 = data.DP6;
    dp7 = data.DP7;
    status = data.Status;
    bb = data.BB;
    note2 = data.note2;
    note2_color = data.note2_color;
    note3 = data.note3;
    note3_color = data.note3_color;
    note4 = data.note4;
    note4_color = data.note4_color;
    note5 = data.note5;
    note5_color = data.note5_color;
    dataTime2 = data.DataTime2;
    usflow = data.USFLOW;
    dsflow = data.DSFLOW;
    response = data.Response;
    packetLoss = data.PacketLoss;
    reportLog = data.ReportLog;
  }
}
