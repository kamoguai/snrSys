import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DefaultTableDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * 大ping資料
 * Date: 2019-05-08
 */
class BigPingTableItem extends StatelessWidget {
  final BigPingViewModel defaultViewModel;
  final dynamic configData;
  User user;
  BigPingTableItem({this.defaultViewModel, this.configData, });

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
    return (deviceWidth / 3);
  }

  _deviceWidth7(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return (deviceWidth / 7);
  }

  _deviceWidth9(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return (deviceWidth / 9);
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

  ///關電按鈕dialog
  showColsePowerDialog(BuildContext context) async{
    var accName = await LocalStorage.get(Config.USER_ACCNAME_KEY);
    var userRes = await UserDao.getUserInfoLocal();
    user = userRes.data;
    if (user.isCMReset == 1)
    await showDialog(
      context: context,
      builder: (context) {
        var dialog = CupertinoAlertDialog(
          content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '確定關閉電源？',
              style: TextStyle(color: Colors.black,),
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('取消', style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(20)),),
            ),
            CupertinoButton(
              onPressed: (){
                _postResetAPI(context, accName);
                Navigator.pop(context);
              },
              child: Text('確定', style: TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(20)),),
            ),
          ],
        );
        return dialog;
      }
    );
  }
  ///重啟按鈕dialog
  showRestartDialog(BuildContext context) async{
    var accName = await LocalStorage.get(Config.USER_ACCNAME_KEY);
    var userRes = await UserDao.getUserInfoLocal();
    user = userRes.data;
    if(user.isCMRestart == 1)
    await showDialog(
      context: context,
      builder: (context) {
        var dialog = CupertinoAlertDialog(
          content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '確定重啟電源？',
              style: TextStyle(color: Colors.black,),
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('取消', style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(20)),),
            ),
            CupertinoButton(
              onPressed: (){
                _postRestartAPI(context, accName);
                Navigator.pop(context);
              },
              child: Text('確定', style: TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(20)),),
            ),
          ],
        );
        return dialog;
      }
    );
  }
  ///post api 關電
  _postResetAPI(context, accName) async{
    await DefaultTableDao.postResetCM(context, cmts: defaultViewModel.cmts, custNo: defaultViewModel.custCode, accName: accName);
  }
  ///post api 重啟
  _postRestartAPI(context, accName) async{
    await DefaultTableDao.postRestartCM(context, cmts: defaultViewModel.cmts, custNo: defaultViewModel.custCode, accName: accName);
  }
  @override
  Widget build(BuildContext context) {
    var netType = 'EXT';
    Map<String, dynamic> snr0 = {};
    Map<String, dynamic> snr1 = {};
    Map<String, dynamic> snr2 = {};
    Map<String, dynamic> snr3 = {};
    Map<String, dynamic> pwr0 = {};
    Map<String, dynamic> pwr1 = {};
    Map<String, dynamic> pwr2 = {};
    Map<String, dynamic> pwr3 = {};
    Map<String, dynamic> u = {};

    if (defaultViewModel.snr != null) {
      u = defaultViewModel.snr["U0"];
      snr0 = u;
      pwr0 = u;
      u = defaultViewModel.snr["U1"];
      snr1 = u;
      pwr1 = u;
      u = defaultViewModel.snr["U2"];
      snr2 = u;
      pwr2 = u;
      u = defaultViewModel.snr["U3"];
      snr3 = u;
      pwr3 = u;
    }
    else {
      snr0 = {"SNR":""};
      snr1 = {"SNR":""};
      snr2 = {"SNR":""};
      snr3 = {"SNR":""};
      pwr0 = {"PWR":""};
      pwr1 = {"PWR":""};
      pwr2 = {"PWR":""};
      pwr3 = {"PWR":""};
    }
    Map<String, dynamic> g0 = {};
    Map<String, dynamic> g1 = {};
    Map<String, dynamic> g2 = {};
    Map<String, dynamic> g3 = {};
    Map<String, dynamic> c0 = {};
    Map<String, dynamic> c1 = {};
    Map<String, dynamic> c2 = {};
    Map<String, dynamic> c3 = {};
    Map<String, dynamic> u0 = {};
    Map<String, dynamic> u1 = {};
    Map<String, dynamic> u2 = {};
    Map<String, dynamic> u3 = {};
    if (defaultViewModel.codeWord != null) {
      u = defaultViewModel.codeWord["U0"];
      g0 = u;
      c0 = u;
      u0 = u;
      u = defaultViewModel.codeWord["U1"];
      g1 = u;
      c1 = u;
      u1 = u;
      u = defaultViewModel.codeWord["U2"];
      g2 = u;
      c2 = u;
      u2 = u;
      u = defaultViewModel.codeWord["U3"];
      g3 = u;
      c3 = u;
      u3 = u;
    }
    else {
      g0 = {"G":""};
      c0 = {"C":""};
      u0 = {"U":""};
      g1 = {"G":""};
      c1 = {"C":""};
      u1 = {"U":""};
      g2 = {"G":""};
      c2 = {"C":""};
      u2 = {"U":""};
      g3 = {"G":""};
      c3 = {"C":""};
      u3 = {"U":""};
    }

    var netStatus = "";
    if(defaultViewModel.status == "") {
      netStatus = "";
    }
    else if (defaultViewModel.status == "online"){
      netStatus = "上線";
    }
    else{
      netStatus = "離線";
    }

    var cmtsStr = "";
    var cifStr = "";
    var nodeStr = "";
    if(defaultViewModel.count != null) {
      cmtsStr = defaultViewModel.count["CMTS"];
      cifStr = defaultViewModel.count["CIF"];
      nodeStr = defaultViewModel.count["NODE"];
    }


    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 25.0,
            padding: EdgeInsets.only(left: 5.0),
            alignment: Alignment.centerLeft,
            child: _autoTextSizeLeft(defaultViewModel.mac, TextStyle(color: Colors.black), context)
          ),
          _buildLine(),
          _autoContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: (_deviceWidth3(context) * 2 + _deviceWidth9(context) * 0.5) - 1 ,
                  child: _autoTextSize(cmtsStr + cifStr + nodeStr, TextStyle(color: Colors.black), context),
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
            height: 52,
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
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.red,
                        width: 1.0,
                        style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: _autoTextSize('關電', TextStyle(color: Colors.red, fontWeight: FontWeight.bold), context),
                    onPressed: (){showColsePowerDialog(context);},
                  ),
                ),
                _buildHeightLine51(),
                Container(
                  color: Color(MyColors.hexFromStr('#ffeef1')),
                  width: ((_deviceWidth9(context) * 4)) - 1,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(snr0["SNR"],
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(snr0["SNR"], 'U0_SNR', netType, configData))), context),
                            ),
                          _buildHeightLine(),
                          Container(
                            width: _deviceWidth9(context) - 1,
                            child: _autoTextSize(snr1["SNR"],
                                TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(snr1["SNR"], 'U1_SNR', netType, configData))), context),
                          ),
                          _buildHeightLine(),
                          Container(
                            width: _deviceWidth9(context) - 1,
                            child: _autoTextSize(snr2["SNR"],
                                TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(snr2["SNR"], 'U2_SNR', netType, configData))), context),
                          ),
                          _buildHeightLine(),
                          Container(
                            width: _deviceWidth9(context) - 1,
                            child: _autoTextSize(snr3["SNR"],
                                TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(snr3["SNR"], 'U3_SNR', netType, configData))), context),
                          ),
                        ],
                      ),
                       _buildLine(),
                       Row(
                         children: <Widget>[
                           Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(pwr0["PWR"],
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(pwr0["PWR"], 'U0_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(pwr1["PWR"],
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(pwr1["PWR"], 'U1_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(pwr2["PWR"],
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(pwr2["PWR"], 'U2_PWR', netType, configData))), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: _deviceWidth9(context) - 1,
                              child: _autoTextSize(pwr3["PWR"],
                                  TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(pwr3["PWR"], 'U3_PWR', netType, configData))), context),
                            ),
                         ],
                       )
                    ],
                  ),
                ),
                _buildHeightLine51(),
                Container(
                  width: _deviceWidth92(context) - 1,
                  padding: EdgeInsets.all(10),
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
                    onPressed: (){showRestartDialog(context);},
                  ),
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
                  child: _autoTextSize(defaultViewModel.dsMer, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'DSMER_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds0, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds0, 'DS0_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds1, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds1, 'DS1_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds2, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds2, 'DS2_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds3, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds3, 'DS3_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds4, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds4, 'DS4_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds5, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds5, 'DS5_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds6, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds6, 'DS6_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.ds7, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.ds7, 'DS7_PING', netType, configData))), context),
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
                  child: _autoTextSize(defaultViewModel.dsdb, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'DSDB_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp0, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp0, 'DP0_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp1, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp1, 'DP1_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp2, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp2, 'DP2_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp3, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp3, 'DP3_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp4, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp4, 'DP4_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp5, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp5, 'DP5_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp6, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp6, 'DP6_PING', netType, configData))), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                  child: _autoTextSize(defaultViewModel.dp7, TextStyle(color: Color(CommonUtils.checkSnrConfigureValueColor(defaultViewModel.dp7, 'DP7_PING', netType, configData))), context),
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
                  child: _autoTextSize(netStatus, TextStyle(color: defaultViewModel.status == "online" ? Colors.blue : Colors.red), context),
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
          SizedBox(height: 25,),
          _buildRedLine(),
          SizedBox(height: 25,),
          Container(
            padding: EdgeInsets.all(5.0),
            alignment: Alignment.centerLeft,
            child: Text('CodeWord', style: TextStyle(color: Colors.black, fontSize: MyScreen.appBarFontSize(context))),
          ),
          _buildLine(),
          Container(
            height: 130.0,
            color: Color(MyColors.hexFromStr('#ffeef1')),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  child: Row(
                    children: <Widget>[
                      Container(width: _deviceWidth7(context) - 1,),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize('正常', TextStyle(color: Colors.blue), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize('校正', TextStyle(color: Colors.black), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2),
                        child: _autoTextSize('掉包', TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  child: Row(
                    children: <Widget>[
                      Container(width: _deviceWidth7(context) - 1, child: _autoTextSize('U0', TextStyle(color: Colors.black), context),),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(g0["G"], TextStyle(color: Colors.blue), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(c0["C"], TextStyle(color: Colors.black), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2),
                        child: _autoTextSize(u0["U"], TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  child: Row(
                    children: <Widget>[
                      Container(width: _deviceWidth7(context) - 1, child: _autoTextSize('U1', TextStyle(color: Colors.black), context),),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(g1["G"], TextStyle(color: Colors.blue), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(c1["C"], TextStyle(color: Colors.black), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2),
                        child: _autoTextSize(u1["U"], TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  child: Row(
                    children: <Widget>[
                      Container(width: _deviceWidth7(context) - 1, child: _autoTextSize('U2', TextStyle(color: Colors.black), context),),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(g2["G"], TextStyle(color: Colors.blue), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(c2["C"], TextStyle(color: Colors.black), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2),
                        child: _autoTextSize(u2["U"], TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
                  child: Row(
                    children: <Widget>[
                      Container(width: _deviceWidth7(context) - 1, child: _autoTextSize('U3', TextStyle(color: Colors.black), context),),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(g3["G"], TextStyle(color: Colors.blue), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2) - 1,
                        child: _autoTextSize(c3["C"], TextStyle(color: Colors.black), context),
                      ),
                      _buildHeightLine(),
                      Container(
                        width: (_deviceWidth7(context) * 2),
                        child: _autoTextSize(u3["U"], TextStyle(color: Colors.red), context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25,),
        ],
      ),
    );
  }
}

class BigPingViewModel {
  String mac;
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
  String dsdb;
  String dsMer;
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

  BigPingViewModel();

  BigPingViewModel.forMap(data) {
    mac = data["MAC"] == null ? "" : data["MAC"];
    cmts = data["CMTS"] == null ? "" : data["CMTS"];
    cif = data["CIF"] == null ? "" : data["CIF"];
    node = data["NODE"] == null ? "" : data["NODE"];
    custCode = data["CustCode"] == null ? "" : data["CustCode"];
    count = data["COUNT"] == null ? "" : data["COUNT"];
    onlineTime = data["ONLINETIME"] == null ? "" : data["ONLINETIME"];
    cmswver = data["CMSWVER"] == null ? "" : data["CMSWVER"];
    custName = data["CustName"] == null ? "" : data["CustName"];
    note1 = data["note1"] == null ? "" : data["note1"];
    note1_color = data["note1_color"] == null ? "000000" : data["note1_color"];
    ds0 = data["DS0"] == null ? "" : data["DS0"];
    ds1 = data["DS1"] == null ? "" : data["DS1"];
    ds2 = data["DS2"] == null ? "" : data["DS2"];
    ds3 = data["DS3"] == null ? "" : data["DS3"];
    ds4 = data["DS4"] == null ? "" : data["DS4"];
    ds5 = data["DS5"] == null ? "" : data["DS5"];
    ds6 = data["DS6"] == null ? "" : data["DS6"];
    ds7 = data["DS7"] == null ? "" : data["DS7"];
    dp0 = data["DP0"] == null ? "" : data["DP0"];
    dp1 = data["DP1"] == null ? "" : data["DP1"];
    dp2 = data["DP2"] == null ? "" : data["DP2"];
    dp3 = data["DP3"] == null ? "" : data["DP3"];
    dp4 = data["DP4"] == null ? "" : data["DP4"];
    dp5 = data["DP5"] == null ? "" : data["DP5"];
    dp6 = data["DP6"] == null ? "" : data["DP6"];
    dp7 = data["DP7"] == null ? "" : data["DP7"];
    dsdb = data["DSDB"] == null ? "" : data["DSDB"];
    dsMer = data["DSMER"] == null ? "" : data["DSMER"];
    status = data["STATUS"] == null ? "" : data["STATUS"];
    bb = data["BB"] == null ? "" : data["BB"];
    buildingName = data["BuildingName"] == null ? "" : data["BuildingName"];
    pingTime = data["PINGTIME"] == null ? "" : data["PINGTIME"];
    note2 = data["note2"] == null ? "" : data["note2"];
    note2_color = data["note2_color"] == null ? "000000" : data["note2_color"];
    note3 = data["note3"] == null ? "" : data["note3"];
    note3_color = data["note3_color"] == null ? "000000" : data["note3_color"];
    note4 = data["note4"] == null ? "" : data["note4"];
    note4_color = data["note4_color"] == null ? "000000" : data["note4_color"];
    note5 = data["note5"] == null ? "" : data["note5"];
    note5_color = data["note5_color"] == null ? "000000" : data["note5_color"];
    usflow = data["USFLOW"] == null ? "" : data["USFLOW"];
    dsflow = data["DSFLOW"] == null ? "" : data["DSFLOW"];
    response = data["Response"] == null ? "" : data["Response"];
    packetLoss = data["PacketLoss"] == null ? "" : data["PacketLoss"];
    snr = data["SNR"] == null ? null : data["SNR"];
    codeWord = data["CodeWord"] == null ? null : data["CodeWord"];
  }
  BigPingViewModel.forDummy(data) {
    mac = "";
    cmts = "";
    cif = "";
    node = "";
    custCode = "";
    count = null;
    onlineTime = "";
    cmswver = "";
    custName = "";
    note1 = "";
    note1_color = "";
    ds0 = "";
    ds1 = "";
    ds2 = "";
    ds3 = "";
    ds4 = "";
    ds5 = "";
    ds6 = "";
    ds7 = "";
    dp0 = "";
    dp1 = "";
    dp2 = "";
    dp3 = "";
    dp4 = "";
    dp5 = "";
    dp6 = "";
    dp7 = "";
    dsdb = "";
    dsMer = "";
    status = "";
    bb = "";
    buildingName = "";
    pingTime = "";
    note2 = "";
    note2_color = "";
    note3 = "";
    note3_color = "";
    note4 = "";
    note4_color = "";
    note5 = "";
    note5_color = "";
    usflow = "";
    dsflow = "";
    response = "";
    packetLoss = "";
    snr = null;
    codeWord = null;
  }
}