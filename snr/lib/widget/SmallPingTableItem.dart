import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/model/CodeWordModel.dart';
import 'package:snr/common/model/SNRModel.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';



class SmallPingTableItem extends StatelessWidget {

  final PingViewModel defaultViewModel;
  final dynamic configData;

  SmallPingTableItem({this.defaultViewModel, this.configData, });

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

  _autoContainer({child, color}) {
    return Container(
      // padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey,
            style: BorderStyle.solid
          )
        )
      ),
      color: color,
      child: child,
    );
  }
 
  @override
  Widget build(BuildContext context) {
    var netType = 'EXT';
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _autoContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: (_deviceWidth3(context) * 2 + _deviceWidth9(context) * 0.5) - 1 ,
                  child: _autoTextSize(defaultViewModel.cmts + defaultViewModel.cif + defaultViewModel.node, TextStyle(color: Colors.black), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth92(context),
                  child: _autoTextSize(defaultViewModel.onlineTime, TextStyle(color: Colors.blue), context),
                ),
              ],
            )
          ),
          _autoContainer(
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth3(context) - 1,
                  child: _autoTextSize(
                      defaultViewModel.custCode, TextStyle(color: Colors.grey), context),
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
                            defaultViewModel.buildingName, TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                _buildHeightLine(),
                Container(
                    width: _deviceWidth92(context),
                    child: Container(
                      child: _autoTextSize(
                          defaultViewModel.custName, TextStyle(color: Colors.black), context),
                    )
                ),
              ],
            ),
          ),
          Container(
            height: 51,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: _deviceWidth92(context) - 1,
                  child: ButtonTheme(
                    padding: EdgeInsets.all(1.0),
                    minWidth: 20,
                    height: 20,
                    child: FlatButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                        style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: _autoTextSize('關電', TextStyle(color: Colors.red, fontWeight: FontWeight.bold), context),
                    onPressed: (){},
                  ),
                  )
                  
                ),
                _buildHeightLine51(),
                Container(
                  width: ((_deviceWidth9(context) * 4)) - 1,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.dp0,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U0_SNR', netType, configData))), context),
                            ),
                          _buildHeightLine(),
                          Container(
                            width: _deviceWidth9(context) - 1,
                            child: _autoTextSize(defaultViewModel.dp0,
                                TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U1_SNR', netType, configData))), context),
                          ),
                          _buildHeightLine(),
                          Container(
                            width: _deviceWidth9(context) - 1,
                            child: _autoTextSize(defaultViewModel.dp0,
                                TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U2_SNR', netType, configData))), context),
                          ),
                          _buildHeightLine(),
                          Container(
                            width: _deviceWidth9(context) - 1,
                            child: _autoTextSize(defaultViewModel.dp0,
                                TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U3_SNR', netType, configData))), context),
                          ),                          
                        ],
                      ),
                       _buildLine(),
                       Row(
                         children: <Widget>[
                           Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.dp0,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U0_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.dp0,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U1_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.dp0,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U2_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(defaultViewModel.dp0,
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'U3_PWR', netType, configData))), context),
                            ),
                         ],
                       )
                    ],
                  ),
                ),
                _buildHeightLine51(),
                Container(
                  width: _deviceWidth92(context) - 1,
                  child: ButtonTheme(
                    padding: EdgeInsets.all(1.0),
                    minWidth: 20,
                    height: 20,
                    child: FlatButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.brown,
                        width: 1.0,
                        style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: _autoTextSize('重啟', TextStyle(color: Colors.brown, fontWeight: FontWeight.bold), context),
                    onPressed: (){},
                  ),
                  )
                ),
              ],
            ),
          ),
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
                  child: _autoTextSize(defaultViewModel.pingTime, TextStyle(color: Color(MyColors.hexFromStr(defaultViewModel.note5_color))), context),
                ),
              ],
            ),
          ),
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
          _autoContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: ButtonTheme(
                    // padding: EdgeInsets.all(1.0),
                    minWidth: 30,
                    height: 20,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: _autoTextSize('大PING', TextStyle(color: Colors.red), context),
                      onPressed: (){},
                    ),
                  ),
                ),
                _buildHeightLine(),
                Container(
                  child: ButtonTheme(
                    // padding: EdgeInsets.all(1.0),
                    minWidth: 30,
                    height: 20,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: _autoTextSize('重啟2', TextStyle(color: Colors.red), context),
                      onPressed: (){},
                    ),
                  ),
                )
              ],
            )
          )
        ],
        /*
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
                  onTap: (){},
                  child: Container(
                    color: Colors.white,
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
        */
      ),
    );
  }
}

class PingViewModel {
  String cmts;
  String cif;
  String node;
  String custCode;
  Map<String,dynamic> count;
  String onlineTime;
  String cmswver;
  String custName;
  String bb;
  String buildingName;
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
  String pingTime;
  String note1;
  String note1_color;
  String note2;
  String note2_color;
  String note3;
  String note3_color;
  String note4;
  String note4_color;
  String note5;
  String note5_color;
  String usflow;
  String dsflow;
  String response;
  String packetLoss;

  Map<String,dynamic> snr;
  Map<String,dynamic> codeWord;

  PingViewModel();

  PingViewModel.forMap(SmallPingTableCell data) {
    cmts = data.CMTS == null ? "" : data.CMTS;
    cif = data.CIF == null ? "" : data.CIF;
    node = data.NODE == null ? "" : data.NODE;
    custCode = data.CustCode == null ? "" : data.CustCode;
    count = data.COUNT == null ? "" : data.COUNT;
    onlineTime = data.ONLINETIME == null ? "" : data.ONLINETIME;
    cmswver = data.CMSWVER == null ? "" : data.CMSWVER;
    custName = data.CustName == null ? "" : data.CustName;
    note1 = data.note1 == null ? "" : data.note1;
    note1_color = data.note1_color == null ? "000000" : data.note1_color;
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
    status = data.STATUS == null ? "" : data.STATUS;
    bb = data.BB == null ? "" : data.BB;
    buildingName = data.BuildingName == null ? "" : data.BuildingName;
    pingTime = data.PINGTIME == null ? "" : data.PINGTIME;
    note2 = data.note2 == null ? "" : data.note2;
    note2_color = data.note2_color == null ? "000000" : data.note2_color;
    note3 = data.note3 == null ? "" : data.note3;
    note3_color = data.note3_color == null ? "000000" : data.note3_color;
    note4 = data.note4 == null ? "" : data.note4;
    note4_color = data.note4_color == null ? "000000" : data.note4_color;
    note5 = data.note5 == null ? "" : data.note5;
    note5_color = data.note5_color == null ? "000000" : data.note5_color;
    usflow = data.USFLOW == null ? "" : data.USFLOW;
    dsflow = data.DSFLOW == null ? "" : data.DSFLOW;
    response = data.Response == null ? "" : data.Response;
    packetLoss = data.PacketLoss == null ? "" : data.PacketLoss;
    snr = data.SNR == null ? [] : data.SNR;
    codeWord = data.CodeWord == null ? [] : data.CodeWord;
  
    
  }
}