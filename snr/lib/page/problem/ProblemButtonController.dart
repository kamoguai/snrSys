import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/common/utils/CommonUtils.dart';
import 'package:snr/widget/MyToolBarButton.dart';

class ProblemButtonController extends StatelessWidget {

  final Function eventAction;
  ProblemButtonController(this.eventAction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ButtonTheme(
            minWidth: 60.0,
            height: 35,
            child: new MyToolButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context).home_btn_bigbad,
              color: Color(MyColors.hexFromStr("#fee9fa")),
              fontSize: MyConstant.smallTextSize,
              textColor: Colors.black,
              onPress: (){
                eventAction();
                print(124);
              },
            ),
          ),
          ButtonTheme(
            minWidth: 60.0,
            height: 35,
            child: new MyToolButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context).home_btn_bigbad,
              color: Color(MyColors.hexFromStr("#fee9fa")),
              fontSize: MyConstant.smallTextSize,
              textColor: Colors.black,
            ),
          ),
          ButtonTheme(
            minWidth: 60.0,
            height: 35,
            child: new MyToolButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context).home_btn_bigbad,
              color: Color(MyColors.hexFromStr("#fee9fa")),
              fontSize: MyConstant.smallTextSize,
              textColor: Colors.black,
            ),
          ),
          ButtonTheme(
            minWidth: 60.0,
            height: 35,
            child: new MyToolButton(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)),
              text: CommonUtils.getLocale(context).home_btn_bigbad,
              color: Color(MyColors.hexFromStr("#fee9fa")),
              fontSize: MyConstant.smallTextSize,
              textColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
