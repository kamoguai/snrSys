
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/AssignFixDao.dart';
import 'package:snr/common/dao/BpDao.dart';
import 'package:snr/common/dao/MaintainLogDao.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/model/SsoLogin.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/BaseWidget.dart';
import 'package:snr/widget/dialog/AddDescriptionDialog.dart';
/**
 * 維修紀錄dialog
 * Date: 2019-05-09
 */
class MaintainLogDialog extends StatefulWidget {

  final String custNo;
  final String wkNo;
  final String custName;
  final String from;
  final int currentCellTag;
  final Function maintainAssignFunc;
  
  MaintainLogDialog({this.custNo, this.wkNo, this.custName, this.from, this.currentCellTag, this.maintainAssignFunc});

  @override
  _MaintainLogDialogState createState() => _MaintainLogDialogState(this.maintainAssignFunc);
}

class _MaintainLogDialogState extends State<MaintainLogDialog> with BaseWidget{
  
  final Function maintainAssignFunc;
  _MaintainLogDialogState(this.maintainAssignFunc);

  ///data相關
  List<dynamic> dataArray = new List<dynamic>();
  ///所選row array
  final List<String> toTransformArray = [];
  ///所選row 狀態，選定時為true，未選為flase
  List<bool> isSelectArray = [];
  /// user model
  User user;
  /// sso model
  Sso sso;
  var isCanAdd = false;
  var tapId = "";
  var tapIndex = 0;
  var tapTarget = "";
  var selectAccNo = "";
  var selectEmpName = "";
  ///初始化
  initParam() async {
    var userRes = await UserDao.getUserInfoLocal();
    var ssoRes = await UserDao.getUserSSOInfoLocal();
    user = userRes.data;
    sso = ssoRes.data;
    user.accNo = await LocalStorage.get(Config.USER_NAME_KEY);
    user.accName = sso.accName;
    
  }
  ///維修記錄指派人員
  Future _openMaintainAssign(empName, currentCellTag) {
    maintainAssignFunc(empName, currentCellTag);
  }
  ///first item
  Widget _firstItem() {
    Widget item;
    if(dataArray.length > 0) {
      var dic = MaintainViewModel.forMap(dataArray[0]);
      item = GestureDetector(
        child: Container(
          decoration: BoxDecoration(color: _changeTransColor(0), border: Border(bottom: BorderSide(width: 1.0, color: Colors.red, style: BorderStyle.solid))),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5.0),
                alignment: Alignment.centerLeft,
                child: autoTextSizeLeft(dic.description, TextStyle(color: Color(MyColors.hexFromStr(dic.descriptionColor))), context),
              ),
              buildLine(),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: deviceWidth3(context) - 1,
                      child: autoTextSize(dic.reportTime, TextStyle(color: Colors.black), context),
                    ),
                    buildLineHeight(context),
                    Container(
                      width: deviceWidth3(context) - 1,
                      child: autoTextSize('', TextStyle(color: Colors.black), context),
                    ),
                    buildLineHeight(context),
                    Container(
                      width: deviceWidth3(context) - 1,
                      child: autoTextSize(dic.senderName, TextStyle(color: Colors.black), context),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          _addTransform(dic.id, 0, accNo: dic.senderID, empName: dic.senderName);
        },
      );
    }
    else {
      item = Container();
    }
    return item;
  }

  ///loglist item
  Widget _logListItem(BuildContext context, int index) {
    var count = index + 1;
    var dicIndex = dataArray[index + 1];
    var dic = MaintainViewModel.forMap(dicIndex);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(color: _changeTransColor(count), border: Border(bottom: BorderSide(width: 1.0, color: Colors.black, style: BorderStyle.solid))),
        child: Column(
          children: <Widget>[
            Container(
              color: _changeTransColor(count, t: 0),
              padding: EdgeInsets.only(left: 5.0),
              alignment: Alignment.centerLeft,
              child: autoTextSizeLeft(dic.description, TextStyle(color: Color(MyColors.hexFromStr(dic.descriptionColor))), context),
            ),
            buildLine(),
            Container(
              color: _changeTransColor(count),
              child: Row(
                children: <Widget>[
                  Container(
                    width: deviceWidth3(context) - 1,
                    child: autoTextSize(dic.reportTime, TextStyle(color: Colors.black), context),
                  ),
                  buildLineHeight(context),
                  Container(
                    width: deviceWidth3(context) - 1,
                    child: autoTextSize('', TextStyle(color: Colors.black), context),
                  ),
                  buildLineHeight(context),
                  Container(
                    width: deviceWidth3(context) - 1,
                    child: autoTextSize(dic.senderName, TextStyle(color: Colors.black), context),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        _addTransform(dic.id, index + 1, accNo: dic.senderID, empName: dic.senderName);
      },
    );
  }

  ///loglsit view
  Widget _logListView() {
    Widget logList;
    if(dataArray.length > 0) {
      logList = Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: _logListItem,
          itemCount: dataArray.length - 1,
        ),
      );
    } 
    else {
      logList = Container(child: Center(child: Text(CommonUtils.getLocale(context).app_empty)));
    }
    return logList;
  }

  ///所選目標function 
  void _addTransform(String id, int index, {accNo, empName}) {
    if (id == "XXXXX") {
      tapTarget = id + "-$index";
    }
    else {
      tapTarget = id;
    }
    setState(() {
      if (toTransformArray.contains(tapTarget)) {
        var targetIndex = toTransformArray.indexOf(tapTarget);
        toTransformArray.removeAt(targetIndex);
        isSelectArray[index] = false;
      }
      else {
        toTransformArray.add(tapTarget);
        isSelectArray[index] = true;
        selectAccNo = accNo;
        selectEmpName = empName;
      }
    });
  }
  
  ///跳轉選定後改變欄位顏色
  Color _changeTransColor(int index, {int t}) {
    if(isSelectArray[index] == true) {
      return Colors.orange;
    }
    else {
      if (index == 0) {
        return Color(MyColors.hexFromStr('#f0fcff'));
      }
      else if (index > 0) {
        if (t == 0) {
          return Colors.white;
        }
        else {
          return Color(MyColors.hexFromStr('#f2f2f2'));
        }
      }
      else {
        return Colors.transparent;
      }
      
    }
  }
  ///刪除dialog
  _deleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var dialog = CupertinoAlertDialog(
          content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                  text: '確定將選取的${toTransformArray.length}筆資料刪除？', 
                  style: TextStyle(color: Colors.black, ),
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('取消', style: TextStyle(color: Colors.red),),
            ),
            CupertinoButton(
              onPressed: (){
                
                deleteData();
                Navigator.pop(context);
              },
              child: Text('確定', style: TextStyle(color: Colors.blue),),
            ),
          ],
        );
        return dialog;
      }
    );
  }
  ///輸入dialog
  _addInputDialog(custNo, custName) {
    var fromFunc = "";
    if (widget.from == "CONFIRM" || widget.from == "BP") {
      switch(widget.from) {
        case "CONFIRM":
          fromFunc = "DEDUCT1";
          break;
        case "BP":
          fromFunc = "DEDUCT2";
          break;
        default:
          fromFunc = widget.from;
      }
    }
    return GestureDetector(
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100,),
            Card(
              child: AddDescriptionDialog(custNo: custNo, wkNo: widget.wkNo, custName: custName, from: fromFunc, senderId: user.accNo, senderName: user.accName,),
            )
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
     
  }
  ///show 加入人員dialog
  _addManDialog(accNo, empName, assignMan) {
    showDialog(
      context: context,
      builder: (context) {
         var dialog = CupertinoAlertDialog(
            content: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '是否確定要將該筆人員填入派工？\n', 
                style: TextStyle(color: Colors.black, ),
                children: <TextSpan>[TextSpan(text: '${empName}', style: TextStyle(color: Colors.blue, )),]
              ),
            ),
            actions: <Widget>[
              CupertinoButton(
                onPressed: (){
                  print('accNo: $accNo, empName: $empName, assignMan: $assignMan');
                  _setAssignMan(accNo: accNo, empName: empName, assignMan: assignMan);
                  Navigator.pop(context);
                },
                child: Text('確定', style: TextStyle(color: Colors.blue),),
              ),
              CupertinoButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('取消', style: TextStyle(color: Colors.red),),
              ),
              
            ],
          );
         return dialog;
      }
    );
  }
  ///呼叫api data
  getDataList() async {
    dataArray.clear();
    isSelectArray.clear();
    if (widget.from == "CONFIRM" || widget.from == "BP") {
      var res = await BpDao.getQueryDeductLog(custCD: widget.custNo, wkNo: widget.wkNo);
      if(res != null && res.result) {
        setState(() {
          isLoading = false;
          dataArray = res.data["Data"];
          for (var i = 0; i < dataArray.length; i++) {
            isSelectArray.add(false);
          }
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    }
    else {
      var res = await MaintainLogDao.getHipassLogData(custNo: widget.custNo);
      if(res != null && res.result) {
        setState(() {
          isLoading = false;
          dataArray = res.data["Data"];
          for (var i = 0; i < dataArray.length; i++) {
            isSelectArray.add(false);
          }
        });
      }
      else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  ///呼叫刪除api
  deleteData() async {
    var fromFunc = "";
    if(widget.from == "CONFIRM" || widget.from == "BP") {
      switch(widget.from) {
        case "CONFIRM":
          fromFunc = "DEDUCT1";
          break;
        case "BP":
          fromFunc = "DEDUCT2";
          break;
      }
      var res = await MaintainLogDao.delReportLog(senderId: user.accNo, senderName: user.accName, logIdList: toTransformArray, custId: widget.custNo, from: fromFunc);
      if(res != null && res.result) {
        toTransformArray.clear();
        isLoading = true;
        getDataList();
      }
    }
    else {
      var res = await MaintainLogDao.delReportLog(senderId: user.accNo, senderName: user.accName, logIdList: toTransformArray, custId: widget.custNo, from: widget.from);
      if(res != null && res.result) {
        toTransformArray.clear();
        isLoading = true;
        getDataList();
      }
    }
  }
  ///post指派人員
  _setAssignMan({accNo, empName, assignMan}) async {
    var res = await AssignFixDao.setAssignMan(custCD: widget.custNo, accNo: accNo, empName: empName, assignMan: assignMan, senderID: user.accNo, senderName: user.accName, from: widget.from );
    if(res != null && res.result) {
      Fluttertoast.showToast(msg: '指派人員 [ $empName ] 成功');
      _openMaintainAssign(empName, widget.currentCellTag);
    }
  }
  @override
  deviceWidth2(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return (width / 2) - 4;
  }
  @override
  deviceWidth3(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return (width / 3) - 3;
  }
  @override
  void initState() {
    super.initState();
    isLoading = true;
    initParam();
    getDataList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget btnAction;
    Widget btnType;
    if(user == null) {
      return Container(width: 150, child: showLoadingAnime(context));
    }
    if(user.isDeleteReportLog == 1) {

      if (toTransformArray.length == 1 && (widget.from == "FIX" || widget.from == "FIX2") || widget.from == "CUT" || widget.from == "WATCH") {
        btnType = Container(
          width: deviceWidth3(context) - 1,
          child: FlatButton(
            textColor: Colors.red,
            child: autoTextSize(CommonUtils.getLocale(context).text_addMan, TextStyle(color: Colors.blue), context),
            onPressed: () {
             _addManDialog(selectAccNo, selectEmpName, selectEmpName);
            },
          ),
        );
      }
      else {
        btnType = Container(
          width: deviceWidth3(context) - 1,
          child: FlatButton(
            textColor: Colors.red,
            child: autoTextSize(CommonUtils.getLocale(context).text_input, TextStyle(color: Colors.blue), context),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => _addInputDialog(widget.custNo, widget.custName)
              );
            },
          ),
        );
      }
      btnAction = Container(
        height: titleHeight(context),
        child: Row(
          children: <Widget>[
            Container(
              width: deviceWidth3(context) - 1,
              child: FlatButton(
                textColor: Colors.red,
                child: autoTextSize(CommonUtils.getLocale(context).text_delete, TextStyle(color: Colors.red), context),
                onPressed: () {
                  _deleteDialog();
                },
              ),
            ),
            buildLineHeight(context),
            btnType,
            buildLineHeight(context),
            Container(
              width: deviceWidth3(context),
              child: FlatButton(
                textColor: Colors.red,
                child: autoTextSize(CommonUtils.getLocale(context).text_leave, TextStyle(color: Colors.black), context),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    }
    else {
      btnAction = Container(
        height: titleHeight(context),
        child: Row(
          children: <Widget>[
            Container(
              width: deviceWidth2(context) - 1,
              child: FlatButton(
                textColor: Colors.red,
                child: autoTextSize(CommonUtils.getLocale(context).text_input, TextStyle(color: Colors.blue), context),
                onPressed: () {
                   showDialog(
                    context: context,
                    builder: (BuildContext context) => _addInputDialog(widget.custNo, widget.custName)
                  );
                },
              ),
            ),
            buildLineHeight(context),
            Container(
              width: deviceWidth2(context) ,
              child: FlatButton(
                textColor: Colors.red,
                child: autoTextSize(CommonUtils.getLocale(context).text_leave, TextStyle(color: Colors.black), context),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    }

    return isLoading ? Container(width: 150, child: showLoadingAnime(context)) :
     Container(
      height: deviceHeight4(context) * 3.5,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(MyColors.hexFromStr('#fafff2')), border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
            height: listHeight(context),
            child: Row(
              children: <Widget>[
                Container(
                  child: autoTextSize('客編: ', TextStyle(color: Colors.black), context),
                ),
                Container(
                  child: autoTextSize(widget.custNo, TextStyle(color: Colors.black), context),
                ),
                SizedBox(width: 20.0,),
                Container(
                  child: autoTextSize('姓名: ', TextStyle(color: Colors.black), context),
                ),
                Container(
                  child: autoTextSize(widget.custName, TextStyle(color: Colors.black), context),
                ),
              ],
            ),
          ),
          _firstItem(),          
          _logListView(),
          buildLine(),
          btnAction,
        ],
      ),
    );
  }
}

class MaintainViewModel {
  String id;
  String reportTime;
  String description;
  String descriptionColor;
  String currentTime;
  String senderID;
  String senderName;

  MaintainViewModel();

  MaintainViewModel.forMap(dic) {
    id = dic["ID"] == null ? "" : dic["ID"];
    reportTime = dic["ReportTime"] == null ? "" : dic["ReportTime"];
    description = dic["Description"] == null ? "" : dic["Description"];
    descriptionColor = dic["DescriptionColor"] == null ? "000000" : dic["DescriptionColor"];
    currentTime = dic["CurrentTime"] == null ? "" : dic["CurrentTime"];
    senderID = dic["SenderID"] == null ? "" : dic["SenderID"];
    senderName = dic["SenderName"] == null ? "" : dic["SenderName"];
  }
}