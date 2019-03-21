import 'package:flutter/material.dart';

class MyTable extends DataTableSource {
  int _selectCount = 0;//當前選中行數

  @override//是否行數不確定
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override//有多少行
  // TODO: implement rowCount
  int get rowCount => null;

  @override//選中行數
  // TODO: implement selectedRowCount
  int get selectedRowCount => null;

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    return null;
  }
}