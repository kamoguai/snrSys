import 'package:flutter/material.dart';
import 'package:snr/common/dao/MaintainLogDao.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/BaseWidget.dart';
/**
 * 新增維修記錄
 * Date: 2019-05-10
 */

class AddDescriptionDialog extends StatefulWidget {
  final String custNo;
  final String wkNo;
  final String custName;
  final String from;
  final String senderId;
  final String senderName;
  AddDescriptionDialog({this.custNo, this.wkNo, this.custName, this.from, this.senderId, this.senderName});
  @override
  _AddDescriptionDialogState createState() => _AddDescriptionDialogState();
}

class _AddDescriptionDialogState extends State<AddDescriptionDialog> with BaseWidget{

  var inputText = "";  
  final fromKey = GlobalKey<FormState>();

  ///call add api
  addDescriptionAPI() async {
    isLoading = true;
    var res;
    if(widget.from == 'DEDUCT1' || widget.from == 'DEDUCT2') {
      res = await MaintainLogDao.addDescription_deduct(custId: widget.custNo, wkNo: widget.wkNo, inputText: inputText, senderId: widget.senderId, senderName: widget.senderName, from: widget.from);
    }
    else {
      res = await MaintainLogDao.addDescription(custId: widget.custNo, inputText: inputText, senderId: widget.senderId, senderName: widget.senderName, from: widget.from);
    }
    if(res != null && res.result) {
      
      Future.delayed(const Duration(seconds: 1),() {
        // isLoading = false;
        Navigator.pop(context);
      });
    }
    else{
      isLoading = false;
    }
  }
  void _submit() {
    if(fromKey.currentState.validate()) {
      fromKey.currentState.save();
      addDescriptionAPI();
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    Widget body;
    if(isLoading) {
      body = showLoadingAnime(context);
    }
    else {
      body = Container(
        width: deviceHeight4(context) * 3,
        child: Column(
          children: <Widget>[
            Container(
              height: listHeight(context),
              decoration: BoxDecoration(color: Color(MyColors.hexFromStr('#f0fcff')), border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey, style: BorderStyle.solid))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: autoTextSize('姓名：${widget.custName}', TextStyle(color: Colors.black), context),
                  ),
                  Container(
                    child: autoTextSize('客編：${widget.custNo}', TextStyle(color: Colors.black), context),
                  )
                ],
              ),
            ),
            Container(
              child: Form(
                key: fromKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(fontSize: MyScreen.normalPageFontSize(context), color: Colors.black),
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: '請輸入回報內容',
                        contentPadding: EdgeInsets.all(5.0)
                      ),
                      validator: (String value) {
                        if(value.isEmpty) {
                          return '回報內容為必填';
                        }
                      },
                      onSaved: (String value) {
                        setState(() {
                          inputText = value;
                        });
                      },
                    ),
                    buildLine(),
                    Container(
                      color: Color(MyColors.hexFromStr('#fff7f6')),
                      height: titleHeight(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: FlatButton(
                              textColor: Colors.blue,
                              child: autoTextSize(CommonUtils.getLocale(context).text_saveData, TextStyle(), context),
                              onPressed: (){
                                _submit();
                                
                              },
                            ),
                          ),
                          buildLineHeight(context),
                          Container(
                            child: FlatButton(
                              textColor: Colors.red,
                              child: autoTextSize(CommonUtils.getLocale(context).text_leave, TextStyle(), context),
                              onPressed: (){
                                FocusScope.of(context).requestFocus(new FocusNode());
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      );
    }
    return body;
  }
}

