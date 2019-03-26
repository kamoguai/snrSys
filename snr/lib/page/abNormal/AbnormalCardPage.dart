import 'package:flutter/material.dart';


class AbnormalCardPage extends StatefulWidget {
  static final String sName = "abnormalCard";

  // final String userName;

  // AbnormalCardPage(this.userName, {Key key}) : super(key: key);

  @override
  _AbnormalCardPageState createState() => _AbnormalCardPageState();
}

class _AbnormalCardPageState extends State<AbnormalCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
    );
  }
}