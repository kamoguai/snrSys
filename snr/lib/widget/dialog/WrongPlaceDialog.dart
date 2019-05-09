



import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/MyListState.dart';

/**
 * 自移，停訊dialog
 * Date: 2019-04-29
 */
class WrongPlaceDialog extends StatefulWidget {
  final wpType;
  WrongPlaceDialog(this.wpType);
  @override
  _WrongPlaceDialogState createState() => _WrongPlaceDialogState();
}

class _WrongPlaceDialogState extends State<WrongPlaceDialog> with AutomaticKeepAliveClientMixin<WrongPlaceDialog>, MyListState<WrongPlaceDialog> {

  ///data 相關
  List<dynamic> dataArray = new List();
  List<dynamic> selectId = new List();
  @override
  bool get isRefreshFirst => false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getApiDataList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///初始化資料
  initData() {
    selectId.clear();
  }
  
  ///取得api資料
  getApiDataList() async {
    isLoading = false;
  }

  ///分隔線
  _buildLine() {
    return new Container(
      height: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線
  _buildLineHeight() {
    return new Container(
      height: _titleHeight(),
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///高分隔線 * 1.5
  _buildLineHeight15() {
    return new Container(
      height: _titleHeight() * 1.5,
      width: 1.0,
      color: Colors.grey,
    );
  }


  ///高分隔線 * 1.5
  _buildListLineHeight15() {
    return new Container(
      height: _listHeight() * 1.5,
      width: 1.0,
      color: Colors.grey,
    );
  }

  ///取得裝置width並切8份
  _deviceWidth4() {
    var width = MediaQuery.of(context).size.width;
    return (width / 4) - 2;
  }

  ///取得裝置height切4分
  _deviceHeight4() {
    AppBar appBar = AppBar();
    var appBarHeight = appBar.preferredSize.height;
    var deviceHeight = MediaQuery.of(context).size.height;
    var height = deviceHeight - appBarHeight;

    return height / 4;
  }

  ///lsit height
  _listHeight() {
    var height = _deviceHeight4();
    return height / 5;
  }

  ///title height
  _titleHeight() {
    var height = _deviceHeight4();
    return height / 4;
  }

  ///自動字大小
  Widget _autoTextSize(text, color) {
    var fontSize = MyScreen.normalPageFontSize_s(context);

    return AutoSizeText(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
      minFontSize: 5.0,
      textAlign: TextAlign.center,
    );
  }

  ///list item
  Widget _buildListItem(BuildContext context, int index) {
    Widget item;
    item = GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: _changeTransColor(index),
          border: Border(
            bottom: BorderSide(width: 1.0,style: BorderStyle.solid,color: Colors.grey)
          )
        ),
        height: _listHeight() * 1.5,
        child: Row(
          children: <Widget>[
            Container(
              width: (_deviceWidth4() * 2) - 1,
              child: _autoTextSize('2200000001', Colors.black),
            ),
            _buildListLineHeight15(),
            Container(
              width: _deviceWidth4() - 1,
              child: _autoTextSize('雙向', Colors.black),
            ),
            _buildListLineHeight15(),
            Container(
              width: _deviceWidth4(),
              child: _autoTextSize('關MAC', Colors.grey),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _addTargetArray(index);
        });
      },
    );
    
    return item;
  } 
  ///選定或解除選定
  void _addTargetArray(index) {
   var indexStr = "${index}";
   setState(() {
    if (selectId.contains(indexStr)) {
      var index = selectId.indexOf(indexStr);
      selectId.removeAt(index);
    }
    else {
      selectId.add(indexStr);
    }
  });
    print('所選ＩＤ => ${selectId}');
  }
  ///選定後改變欄位顏色
  Color _changeTransColor(index) {
    var indexStr = "${index}";
    if(selectId.contains(indexStr)) {
      return Color(MyColors.hexFromStr('#fdeadb'));
    }
    else {
      return Color(MyColors.hexFromStr('#fef5f6'));
    }
  }

  /// listview
  Widget _buildListView() {
    Widget list;
    // if(dataArray.length > 0) {
      list = Expanded(
        child: ListView.builder(
          itemBuilder: _buildListItem,
          itemCount: dataArray.length + 3,
        ),
      );
    // }
    // else {
    //   list = Container(child: buildEmpty(),);
    // }
    return list;
  }

  ///buttons 
  Widget _buildButtonAction() {
    return Container(
      height: _titleHeight() * 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: FlatButton(
              child: _autoTextSize('確定', Colors.blue),
              onPressed: (){
                _showlog(context);
                // Navigator.pop(context);
                
                // Fluttertoast.showToast(msg: 'ok click');
                // return;
              },
            ),
          ),
          _buildLineHeight15(),
          Container(
            child: FlatButton(
              child: _autoTextSize('離開', Colors.red),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  _showlog(BuildContext context) {
    var textMSG = "";
    var cardColor = "";
    if (widget.wpType == "停訊") {
      textMSG = '確定要關${selectId.length}台機上盒的授權嗎？';
      cardColor = "#fef5f6";
    }
    else {
      textMSG = '確定要對${selectId.length}台機上盒重開授權嗎？';
      cardColor = "#f5ffe9";
    }
    showDialog(
      context: context,
      builder: (context) {
        var log =  Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Color(MyColors.hexFromStr(cardColor)),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: _titleHeight(),
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: _autoTextSize('姓名', Colors.black),
                          ),
                          SizedBox(width: 10.0,),
                          Container(
                            child: _autoTextSize('客編', Colors.black),
                          )
                        ],
                      )
                    ),
                    _buildLine(),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: _titleHeight() * 1.5,
                        child: _autoTextSize(textMSG, Colors.black),
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 20.0,),
              Card(
                child: Container(
                  alignment: Alignment.center,
                  height: _titleHeight() * 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          child: _autoTextSize('確定', Colors.blue),
                          onPressed: (){
                            Fluttertoast.showToast(msg: 'ok click');
                            return;
                          },
                        ),
                      ),
                      _buildLineHeight15(),
                      Container(
                        child: FlatButton(
                          child: _autoTextSize('離開', Colors.red),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
          
        );
        return log;
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    var cardColor = "";
    if (widget.wpType == "停訊") {
      cardColor = "#f0fcff";
    }
    else {
      cardColor = "#f5ffe9";
    }
    if (isLoading) {
      return showLoadingAnime(context);
    }
    else {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              height: _listHeight(),
              color: Color(MyColors.hexFromStr(cardColor)),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: _autoTextSize('姓名', Colors.black),
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    child: _autoTextSize('客編', Colors.black),
                  )
                ],
              ),
            ),
            _buildLine(),
            Container(
              height: _titleHeight(),
              color: Color(MyColors.hexFromStr('#f0fcff')),
              child: Row(
                children: <Widget>[
                  Container(
                    width: (_deviceWidth4() * 2) - 1,
                    child: _autoTextSize('機號', Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth4() - 1,
                    child: _autoTextSize('機型', Colors.black),
                  ),
                  _buildLineHeight(),
                  Container(
                    width: _deviceWidth4(),
                    child: _autoTextSize('授權', Colors.black),
                  )
                ],
              ),
            ),
            _buildLine(),
            _buildListView(),
            _buildLine(),
            _buildButtonAction()
          ],
        ),
      );
    }
    
  }
}