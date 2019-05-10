import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/BaseWidget.dart';
import 'package:snr/widget/helper/ensure_visible.dart';
/**
 * 新增維修記錄
 * Date: 2019-05-10
 */

class AddDescriptionDialog extends StatefulWidget {
  final String custNo;
  final String custName;
  final String from;
  AddDescriptionDialog(this.custNo, this.custName, this.from);
  @override
  _AddDescriptionDialogState createState() => _AddDescriptionDialogState();
}

class _AddDescriptionDialogState extends State<AddDescriptionDialog> with BaseWidget{

  final _descriptionFocusNode = FocusNode();
  var inputText = "";  

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height: deviceHeight4(context),
            child: EnsureVisibleWhenFocused(
              focusNode: _descriptionFocusNode,
              child: TextFormField(
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
                  inputText = value;
                },
              ),
            )
          ),
          buildLine(),
          Container(
            color: Color(MyColors.hexFromStr('#fff7f6')),
            height: titleHeight(context),
            child: Row(
              children: <Widget>[
                Container(
                  child: FlatButton(
                    textColor: Colors.blue,
                    child: autoTextSize(CommonUtils.getLocale(context).text_saveData, TextStyle(), context),
                    onPressed: (){

                    },
                  ),
                ),
                buildLineHeight(context),
                Container(
                  child: FlatButton(
                    textColor: Colors.red,
                    child: autoTextSize(CommonUtils.getLocale(context).text_leave, TextStyle(), context),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

