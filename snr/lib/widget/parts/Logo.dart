


import 'package:flutter/material.dart';
import 'package:snr/common/style/MyStyle.dart';
/**
 * appbar用logo
 * Date: 2019-04-26
 */
class Logo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(MyICons.DEFAULT_USER_ICON,width: 30,),
        SizedBox(
          width: 3,
        ),
        Text('DCTV')
      ],
    );
  }
}