

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';

class AssignFixDao {
  ///派修列表
  static getQueryAssignFixList() async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(Address.getQueryAssignFixList(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryAssignFixList resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
      if (mainDataArray.length > 0) {
        dataArray = mainDataArray["Data"];

        return new DataResult(dataArray, true);
      } else {
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }

  ///派修大樓列表
  static getBuildAnalyse(type) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(Address.getBuildAnalyse(type), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryAssignFixList resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
      if (mainDataArray.length > 0) {
        dataArray = mainDataArray["Data"];

        return new DataResult(dataArray, true);
      } else {
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  
}