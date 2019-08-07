


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:snr/common/model/WrongPlaceTableCell.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * 位置錯誤tableItem
 * Date: 2019-04-26
 */
class WrongPlaceTableItem extends StatelessWidget {
final WrongPlaceViewModel defaultViewModel;
  
  final Function addTransform;
  final Function callRefreshAPI;
  final List<String> addTransformArray;
  final int currentCellTag;
 
  WrongPlaceTableItem({this.defaultViewModel, this.addTransform, this.addTransformArray, this.currentCellTag, this.callRefreshAPI});
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
  _buildHeightLine52() {
    return new Container(
      height: 52.0,
      width: 1.0,
      color: Colors.grey,
    );
  }

  _buildHeight() {
    return 25.0;
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
  Widget _container({child, width, height, color}) {

    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(width: 1.0,style: BorderStyle.solid,color: Colors.grey)
        )
      ),
      height: height == null ? 25.0 : height,
      width: width,
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

  Future _refreshAction(custNo, currentCellTag) async{
    callRefreshAPI(custNo, currentCellTag);
  }
  @override
  Widget build(BuildContext context) {
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
          _container(
            height: (_buildHeight() * 2) + 2,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    color: _changeTransColor(),
                    width: (_deviceWidth3(context) + _deviceWidth9(context) * 0.25) - 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: _buildHeight(),
                          child: _autoTextSize(defaultViewModel.installMan, TextStyle(color: Colors.grey,), context),
                        ),
                        _buildLine(),
                        Container(
                          height: _buildHeight(),
                          child: _autoTextSize(defaultViewModel.custNo, TextStyle(color: Colors.grey,), context),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){addTransform(defaultViewModel.custNo);},
                ),
                
                _buildHeightLine52(),
                Container(
                  width: (_deviceWidth3(context) + _deviceWidth9(context) * 0.25) - 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: _buildHeight(),
                        child: _autoTextSize(defaultViewModel.installDate, TextStyle(color: Colors.grey,), context),
                      ),
                      _buildLine(),
                      Container(
                        height: _buildHeight(),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: _deviceWidth9(context) * 0.5 - 1,
                              child: _autoTextSize('', TextStyle(color: Colors.red,), context),
                            ),
                            _buildHeightLine(),
                            Container(
                              width: (_deviceWidth3(context) - _deviceWidth9(context) * 0.25 ) - 1,
                                    child: _autoTextSize(defaultViewModel.custClass, TextStyle(color: Colors.grey,), context),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                _buildHeightLine52(),
                Container(
                  width: _deviceWidth92(context),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: _buildHeight(),
                        child: _autoTextSize(defaultViewModel.note6, TextStyle(color: Colors.blue,), context),
                      ),
                      _buildLine(),
                      Container(
                        height: _buildHeight(),
                        width: _deviceWidth92(context),
                        child: _autoTextSize(defaultViewModel.name, TextStyle(color: Colors.black,), context),
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
          _container(
            height: (_buildHeight() * 2) + 2,
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth3(context) + _deviceWidth9(context) * 0.25) - 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(MyColors.hexFromStr('#f2f2f2')),
                        height: _buildHeight(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _autoTextSize('BOSS位置', TextStyle(color: Colors.black), context),
                          ],
                        )
                      ),
                      _buildLine(),
                      Container(
                        color: Color(MyColors.hexFromStr('#f5ffe9')),
                        height: _buildHeight(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _autoTextSize(defaultViewModel.bossNodePath, TextStyle(color: Colors.black), context),
                          ],
                        )
                      )
                    ],
                  ),
                ),
                _buildHeightLine52(),
                Container(    
                  width: (_deviceWidth3(context) + _deviceWidth9(context) * 0.25) - 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(MyColors.hexFromStr('#f2f2f2')),
                        height: _buildHeight(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _autoTextSize('卡板位置', TextStyle(color: Colors.black), context),
                          ],
                        )
                      ),
                      _buildLine(),
                      Container(
                        color: Color(MyColors.hexFromStr('#f5ffe9')),
                        height: _buildHeight(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _autoTextSize(defaultViewModel.realNodePath, TextStyle(color: Colors.red), context),
                          ],
                        )
                      )
                    ],
                  ),
                ),
                _buildHeightLine52(),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: _deviceWidth92(context),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey,width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(5.0))
                    ),
                    child: _autoTextSize('刷新', TextStyle(color: Colors.blue), context),
                    onPressed: (){
                      _refreshAction(defaultViewModel.custNo, currentCellTag);
                    },
                  ),
                ),
              ],
            ),
          ),
          _container(
            child: Row(
              children: <Widget>[
                Container(
                  width: (_deviceWidth9(context) + _deviceWidth9(context) * 0.25 - 1),
                  child: _autoTextSize(defaultViewModel.status == 1 ? "上線" : "離線", TextStyle(color: defaultViewModel.status == 1 ? Colors.blue : Colors.red), context),
                ),
                _buildHeightLine(),
                Container(
                  width: (_deviceWidth9(context) + _deviceWidth9(context) * 0.25 - 1),
                  child: _autoTextSize(defaultViewModel.bb, TextStyle(color: Colors.blue), context),
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth9(context) - 1,
                ),
                _buildHeightLine(),
                Container(
                  width: _deviceWidth92(context),
                ),
              ],
            )
          ),
          _container(),
          _buildRedLine()
        ],
      ),
    );
  }
}

class WrongPlaceViewModel {
  String address;//地址
  String custNo;//客編
  String installDate;//裝機時間
  String name;//客名
  String note6;//雙分:單分
  int status;//狀態
  String installMan;//裝機人
  String bb;//網速
  String custClass;//大樓
  String realNodePath;//真實位置
  String bossNodePath;//boss位置

  WrongPlaceViewModel();

  WrongPlaceViewModel.forMap(WrongPlaceTableCell data) {
    address = data.Address == null ? "" : data.Address;
    installMan = data.InstallMan == null ? "" : data.InstallMan;
    installDate = data.InstallDate == null ? "" : data.InstallDate;
    realNodePath = data.RealNodePath == null ? "" : data.RealNodePath;
    note6 = data.note6 == null ? "" : data.note6;
    bossNodePath = data.BossNodePath == null ? "" : data.BossNodePath;
    custNo = data.CustNo == null ? "" : data.CustNo;
    custClass = data.CustClass == null ? "" : data.CustClass;
    name = data.Name == null ? "" : data.Name;
    status = data.Status == null ? 0 : data.Status;
    bb = data.BB == null ? "" : data.BB;
  }
}