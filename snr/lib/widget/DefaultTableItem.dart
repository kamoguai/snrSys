import 'package:flutter/material.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';

/**
 * 通用table item
 * Date: 2019-04-02
 */
class DefaultTableItem extends StatelessWidget {

  final DefaultViewModel defaultViewModel;
  final dynamic configData;
  final Function addTransform;
  final List<String> addTransformArray;
  DefaultTableItem({this.defaultViewModel, this.configData, this.addTransform, this.addTransformArray});
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

  _buildHeightLine51() {
    return new Container(
      height: 51.0,
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

  Widget _autoTextSize_s(text, style, context) {
    var fontSize = MyScreen.defaultTableCellFontSize_s(context);
    var fontStyle = TextStyle(fontSize: fontSize);
    return AutoSizeText(
      text,
      style: style.merge(fontStyle),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
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
  ///跳轉選定後改變欄位顏色
  Color _changeTransColor() {
    if(addTransformArray.contains(defaultViewModel.custNo)) {
      return Colors.orange;
    }
    else {
      return Colors.white;
    }
  }
 

  @override
  Widget build(BuildContext context) {
    var netType = 'EXT';
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: (){print(123);},
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _autoContainer_full(child: _autoTextSize(defaultViewModel.address,TextStyle(color: Colors.grey), context), ),
                _buildLine(),
                _autoContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: _deviceWidth3(context) - 1,
                        child: _autoTextSize(defaultViewModel.installMan,TextStyle(color: Colors.grey), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: _deviceWidth3(context) - 1,
                        child: _autoTextSize(defaultViewModel.installDate,TextStyle(color: Colors.grey), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: _deviceWidth3(context),
                        child: _autoTextSize(defaultViewModel.saleMan,TextStyle(color: Colors.grey), context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          _buildLine(),
          _autoContainer(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: _deviceWidth3(context) - 1,
                  child: _autoTextSize(
                      defaultViewModel.realNodePath, TextStyle(color: Colors.grey), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth3(context) - 1,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: _deviceWidth9(context) - 1,
                        child: _autoTextSize_s(
                            defaultViewModel.note6, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note6_color))), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth9(context) * 2 - 1),
                        child: _autoTextSize(defaultViewModel.maintainTime,
                            TextStyle(color: Colors.brown), context),
                      ),
                    ],
                  ),
                ),
                _buildHeightLine(),
                GestureDetector(
                  onTap: (){
                    print('assignman');
                  },
                  child: Container(
                    width: _deviceWidth3(context),
                    child: _autoTextSize(defaultViewModel.assignMan,TextStyle(color: Colors.brown), context),
                  ),
                ),
              ],
            ),
          ),
          _buildLine(),
          _autoContainer(
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth3(context) * 2) - 1,
                  child: _autoTextSize(
                      defaultViewModel.bossNodePath, TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth3(context),
                  child: Container(
                    child: _autoTextSize(
                        defaultViewModel.otime, TextStyle(color: Colors.blue), context),
                  ),
                )
              ],
            ),
          ),
          _buildLine(),
          _autoContainer(
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth3(context) - 1,
                  child: _autoTextSize(
                      defaultViewModel.custNo, TextStyle(color: Colors.grey), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth3(context) - 1,
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
                        
                        width: (_deviceWidth3(context) / 1.22),
                        child: _autoTextSize(
                            defaultViewModel.custClass, TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                _buildHeightLine(),
                Container(
                    width: _deviceWidth3(context),
                    child: Container(
                      child: _autoTextSize(
                          defaultViewModel.name, TextStyle(color: Colors.black), context),
                    )),
              ],
            ),
          ),
          _buildLine(),
          Container(
            // decoration: BoxDecoration(border: Border()),
            height: 51.0,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){addTransform(defaultViewModel.custNo);},
                  child: Container(
                    color: _changeTransColor(),
                    width: (_deviceWidth9(context) * 2) - 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          // decoration: BoxDecoration(border: Border()),
                          height: 25.0,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: _deviceWidth9(context) - 1,
                                child: _autoTextSize(defaultViewModel.isMarjor, TextStyle(color: Colors.red), context),
                              ),
                              _buildHeightLine(),
                              Container(
                                width: _deviceWidth9(context) - 1,
                                child: _autoTextSize_s(defaultViewModel.restartCount,TextStyle(color: Colors.black), context),
                              ),
                            ],
                          ),
                        ),
                        _buildLine(),
                        Container(
                          // decoration: BoxDecoration(border: Border()),
                          height: 25.0,
                          child: _autoTextSize_s(defaultViewModel.restartTime,TextStyle(color: Colors.black), context),
                        ),
              
                      ],
                    ),
                  ),
                ),
                _buildHeightLine51(),
                GestureDetector(
                  child:  Container(
                    decoration: BoxDecoration(border: Border()),
                    width: (_deviceWidth9(context) * 4) - 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u0_SNR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u0_SNR, 'U0_SNR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u1_SNR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u1_SNR, 'U1_SNR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u2_SNR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u2_SNR, 'U2_SNR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u3_SNR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u3_SNR, 'U3_SNR', netType, configData))), context),
                            ),
                          ],
                        ),
                        _buildLine(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u0_PWR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u0_PWR, 'U0_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u1_PWR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u1_PWR, 'U1_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u2_PWR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u2_PWR, 'U2_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.u3_PWR,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.u3_PWR, 'U3_PWR', netType, configData))), context),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ),
                  onTap: (){print(123);},
                ),
                _buildHeightLine51(),
                GestureDetector(
                  child: Container(
                    width: _deviceWidth3(context),
                    // padding: EdgeInsets.all(2.0),
                    child: Image.asset('static/images/pingBtn.png', height: 40.0, width: 40.0),
                  ),
                  onTap: (){print('ping');},
                ),
                
              ],
            ),
          ),
          _buildLine(),
          Container(
            color: Color(MyColors.hexFromStr('#f1f1f1')),
            height: 25.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.blue), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds0, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds0, 'DS0', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds1, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds1, 'DS1', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds2, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds2, 'DS2', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds3, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds3, 'DS3', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds4, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds4, 'DS4', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds5, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds5, 'DS5', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds6, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds6, 'DS6', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds7, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds7, 'DS7', netType, configData))), context),
                ),
              ],
            ),
          ),
          _buildLine(),
          Container(
            color: Color(MyColors.hexFromStr('#f1f1f1')),
            height: 25.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.blue), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp0, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'DP0', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp1, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp1, 'DP1', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp2, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp2, 'DP2', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp3, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp3, 'DP3', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp4, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp4, 'DP4', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp5, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp5, 'DP5', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp6, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp6, 'DP6', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp7, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp7, 'DP7', netType, configData))), context),
                ),
              ],
            ),
          ),
          _buildLine(),
          _autoContainer(
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth9(context) * 1.5) - 1,
                  child: _autoTextSize(defaultViewModel.status == "1" ? "上線" : "離線", TextStyle(color: defaultViewModel.status == "1" ? Colors.blue : Colors.red), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context) * 1.5) - 1,
                  child: _autoTextSize(defaultViewModel.bb, TextStyle(color: Colors.blue), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context)) - 1,
                  child: _autoTextSize(defaultViewModel.note2, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note2_color))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context)) - 1,
                  child: _autoTextSize(defaultViewModel.note3, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note3_color))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context)) - 1,
                  child: _autoTextSize(defaultViewModel.note4, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note4_color))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context)) - 1,
                  child: _autoTextSize(defaultViewModel.note5, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note4_color))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context) * 2),
                  child: _autoTextSize(defaultViewModel.dataTime2, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note5_color))), context),
                ),
              ],
            ),
          ),
          _buildLine(),
          Container(
            color: Color(MyColors.hexFromStr('#f1f1f1')),
            height: 25.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize('校正', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                   Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                   Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                   Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
              ],
            ),
          ),
          _buildLine(),
          Container(
            color: Color(MyColors.hexFromStr('#f1f1f1')),
            height: 25.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize('掉包', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                   Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                   Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                   Container(
                  width: (_deviceWidth9(context) * 2) - 1,
                  child: _autoTextSize('', TextStyle(color: Colors.black), context),
                ),
              ],
            ),
          ),
          _buildLine(),
          GestureDetector(
            child: Column(
              children: <Widget>[
                _autoContainer(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: (_deviceWidth9(context) * 2.5) - 1,
                        child: _autoTextSize('上:${defaultViewModel.usflow}', TextStyle(color: Colors.red), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth9(context) * 2.5) - 1,
                        child: _autoTextSize('下:${defaultViewModel.dsflow}', TextStyle(color: Colors.blue), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth9(context) * 2) - 1,
                        child: _autoTextSize('回:${defaultViewModel.response}', TextStyle(color: Colors.black), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth9(context) * 2) - 1,
                        child: _autoTextSize('掉:${defaultViewModel.packetLoss}', TextStyle(color: Colors.black), context),
                      ),
                      
                    ],
                  ),
                ),
                _buildLine(),
                _autoContainer_full(
                  child: _autoTextSize(defaultViewModel.reportLog, TextStyle(color:  Color(MyColors.hexFromStr(defaultViewModel.reportLogColor))), context),
                )
              ],
            ),
            onTap: (){print("showLog");},
          ),
          
          _buildRedLine()
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
  String reportLogColor;
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
    address = data.Address == null ? "" : data.Address;
    installMan = data.InstallMan == null ? "" : data.InstallMan;
    installDate = data.InstallDate == null ? "" : data.InstallDate;
    saleMan = data.SaleMan == null ? "" : data.SaleMan;
    realNodePath = data.RealNodePath == null ? "" : data.RealNodePath;
    note6 = data.note6 == null ? "" : data.note6;
    note6_color = data.note6_color == null ? "000000" : data.note6_color;
    maintainTime = data.MaintainTime == null ? "" : data.MaintainTime;
    assignMan = data.AssignMan == null ? "" : data.AssignMan;
    bossNodePath = data.BossNodePath == null ? "" : data.BossNodePath;
    otime = data.OTIME == null ? "" : data.OTIME;
    custNo = data.CustNo == null ? "" : data.CustNo;
    note1 = data.note1 == null ? "" : data.note1;
    note1_color = data.note1_color == null ? "000000" : data.note1_color;
    custClass = data.CustClass == null ? "" : data.CustClass;
    name = data.Name == null ? "" : data.Name;
    isMarjor = data.isMarjor == null ? "" : data.isMarjor;
    restartCount = data.RestartCount == null ? "" : data.RestartCount;
    restartTime = data.RestartTime == null ? "" : data.RestartTime;
    u0_SNR = data.U0_SNR == null ? "" : data.U0_SNR;
    u1_SNR = data.U1_SNR == null ? "" : data.U1_SNR;
    u2_SNR = data.U2_SNR == null ? "" : data.U2_SNR;
    u3_SNR = data.U3_SNR == null ? "" : data.U3_SNR;
    u0_PWR = data.U0_PWR == null ? "" : data.U0_PWR;
    u1_PWR = data.U1_PWR == null ? "" : data.U1_PWR;
    u2_PWR = data.U2_PWR == null ? "" : data.U2_PWR;
    u3_PWR = data.U3_PWR == null ? "" : data.U3_PWR;
    ds0 = data.DS0 == null ? "" : data.DS0;
    ds1 = data.DS1 == null ? "" : data.DS1;
    ds2 = data.DS2 == null ? "" : data.DS2;
    ds3 = data.DS3 == null ? "" : data.DS3;
    ds4 = data.DS4 == null ? "" : data.DS4;
    ds5 = data.DS5 == null ? "" : data.DS5;
    ds6 = data.DS6 == null ? "" : data.DS6;
    ds7 = data.DS7 == null ? "" : data.DS7;
    dp0 = data.DP0 == null ? "" : data.DP0;
    dp1 = data.DP1 == null ? "" : data.DP1;
    dp2 = data.DP2 == null ? "" : data.DP2;
    dp3 = data.DP3 == null ? "" : data.DP3;
    dp4 = data.DP4 == null ? "" : data.DP4;
    dp5 = data.DP5 == null ? "" : data.DP5;
    dp6 = data.DP6 == null ? "" : data.DP6;
    dp7 = data.DP7 == null ? "" : data.DP7;
    status = data.Status == null ? "" : data.Status;
    bb = data.BB == null ? "" : data.BB;
    note2 = data.note2 == null ? "" : data.note2;
    note2_color = data.note2_color == null ? "000000" : data.note2_color;
    note3 = data.note3 == null ? "" : data.note3;
    note3_color = data.note3_color == null ? "000000" : data.note3_color;
    note4 = data.note4 == null ? "" : data.note4;
    note4_color = data.note4_color == null ? "000000" : data.note4_color;
    note5 = data.note5 == null ? "" : data.note5;
    note5_color = data.note5_color == null ? "000000" : data.note5_color;
    dataTime2 = data.DataTime2 == null ? "" : data.DataTime2;
    usflow = data.USFLOW == null ? "" : data.USFLOW;
    dsflow = data.DSFLOW == null ? "" : data.DSFLOW;
    response = data.Response == null ? "" : data.Response;
    packetLoss = data.PacketLoss == null ? "" : data.PacketLoss;
    reportLog = data.ReportLog == null ? "" : data.ReportLog;
    reportLogColor = data.ReportLogColor == null ? "000000" : data.ReportLogColor;
    
  }
}
