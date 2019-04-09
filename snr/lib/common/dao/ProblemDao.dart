

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/redux/DefaultTableCellReducer.dart';

class ProblemDao {
  ///地區問題
  static getProblemList(Store store, {type, city, sort, hub}) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(Address.getQueryListAPI(type, city, sort, hub), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getProblemList resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
      if (mainDataArray.length > 0) {
        List<DefaultTableCell> list = new List();
        dataArray = mainDataArray["Data"];
        if (dataArray.length > 0 ) {
          for (var dic in dataArray) {
            list.add(DefaultTableCell.fromJson(dic));
          }
        store.dispatch(new RefreshDefaultTableCellAction(list));
        return new DataResult(list, true);
        }
       return new DataResult(null, false);
      } else {
        return new DataResult(null, false);
      }
    }
    else {
      return new DataResult(null, false);
    }
  }
  ///可異裡面的問題
  static getSNRProblemsAllBadSignal(Store store, {city, sort, hub, typeValue, typeOf, accNo}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getSNRProblemsAllBadSignalAPI(city, sort, hub, typeValue, typeOf, accNo), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getSNRProblemsAllBadSignal resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
      if (mainDataArray.length > 0) {
        return new DataResult(mainDataArray, true);
      } else {
        return new DataResult(null, false);
      }
    }
    else {
      return new DataResult(null, false);
    }
  }
}