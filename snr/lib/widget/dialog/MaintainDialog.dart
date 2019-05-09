
import 'package:flutter/material.dart';
import 'package:snr/common/dao/MaintainLogDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/BaseWidget.dart';
/**
 * 維修紀錄dialog
 * Date: 2019-05-09
 */
class MaintainLogDialog extends StatefulWidget {

  final String custNo;
  final String custName;
  
  MaintainLogDialog({this.custNo, this.custName});

  @override
  _MaintainLogDialogState createState() => _MaintainLogDialogState();
}

class _MaintainLogDialogState extends State<MaintainLogDialog> with BaseWidget{
 

  ///data相關
  List<dynamic> dataArray = new List<dynamic>();
  final List<String> toTransformArray = [];
  var isCanAdd = false;
  var tapId = "";
  var tapIndex = 0;
  var tapTarget = "";
  ///first item
  Widget _firstItem() {
    Widget item;
    if(dataArray.length > 0) {
      var dic = MaintainViewModel.forMap(dataArray[0]);
      item = GestureDetector(
        child: Container(
          decoration: BoxDecoration(color: _changeTransColor(), border: Border(bottom: BorderSide(width: 1.0, color: Colors.red, style: BorderStyle.solid))),
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
          _addTransform(dic.id, 0);
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
    var dicIndex = dataArray[index + 1];
    var dic = MaintainViewModel.forMap(dicIndex);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(color: _changeTransColor(), border: Border(bottom: BorderSide(width: 1.0, color: Colors.black, style: BorderStyle.solid))),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5.0),
              alignment: Alignment.centerLeft,
              child: autoTextSizeLeft(dic.description, TextStyle(color: Color(MyColors.hexFromStr(dic.descriptionColor))), context),
            ),
            buildLine(),
            Container(
              color: Color(MyColors.hexFromStr('#f2f2f2')),
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
        _addTransform(dic.id, index + 1);
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

    ///跳轉function 
  void _addTransform(String id, int index) {
    if (id == "XXXXX") {
      tapTarget = id + "-$index";
    }
    else {
      tapTarget = id;
    }
    setState(() {
      if (toTransformArray.contains(tapTarget)) {
        var index = toTransformArray.indexOf(tapTarget);
        toTransformArray.removeAt(index);
      }
      else {
        toTransformArray.add(tapTarget);
      }
      print("select target => $toTransformArray");
    });
  }
  
  ///跳轉選定後改變欄位顏色
  Color _changeTransColor() {
    if(toTransformArray.contains(tapTarget)) {
      return Colors.orange;
    }
    else {
      return Colors.transparent;
    }
  }
  
  ///呼叫api data
  getDataList() async {
    var res = await MaintainLogDao.getHipassLogData(custNo: widget.custNo);
    if(res != null && res.result) {
      setState(() {
        isLoading = false;
        dataArray = res.data["Data"];
      });
    }
    else {
      setState(() {
        isLoading = false;
      });
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
    getDataList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget btnAction;
    if(isCanAdd) {
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

                },
              ),
            ),
            buildLineHeight(context),
            Container(
              width: deviceWidth3(context) - 1,
              child: FlatButton(
                textColor: Colors.red,
                child: autoTextSize(CommonUtils.getLocale(context).text_input, TextStyle(color: Colors.blue), context),
                onPressed: () {
                  
                },
              ),
            ),
            buildLineHeight(context),
            Container(
              width: deviceWidth3(context),
              child: FlatButton(
                textColor: Colors.red,
                child: autoTextSize(CommonUtils.getLocale(context).text_leave, TextStyle(color: Colors.black), context),
                onPressed: () {
                  
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
                child: autoTextSize(CommonUtils.getLocale(context).text_delete, TextStyle(color: Colors.red), context),
                onPressed: () {
                  Navigator.pop(context);
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
      height: deviceHeight4(context) * 4,
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