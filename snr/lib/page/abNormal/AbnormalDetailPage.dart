import 'package:flutter/material.dart';
import 'package:snr/widget/DefaultTableItem.dart';

class AbnormalDetialPage extends StatefulWidget {
  static final String sName = "abnormalDetial";


  AbnormalDetialPage({Key key}) : super(key: key);
  @override
  _AbnormalDetialPageState createState() => _AbnormalDetialPageState();
}

class _AbnormalDetialPageState extends State<AbnormalDetialPage> {

  _renderItem() {
    return new DefaultTableItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: _renderItem(),
    );
  }
}