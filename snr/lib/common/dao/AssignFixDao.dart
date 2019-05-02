

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
/**
 * 派修dao
 * Date: 2014-03-21
 */
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
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
  ///派修詳情
  static getAssignFix(Store store, {city, sort, hub, typeValue, typeOf, accNo}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getAssignFixOther(city, sort, hub, typeValue, typeOf, accNo), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getAssignFix resp => " + res.data.toString());
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
  ///完工詳情
  static getFinishedFix({city, sort, hub, day, accNo}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getAssignFixFinished(city, sort, hub, day, accNo), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getFinishedFix resp => " + res.data.toString());
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
  ///完工統計列表
  static getQueryFinishAnalyse({date}) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(Address.getQueryFinishAnalyseAPI(date), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryFinishAnalyse resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
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