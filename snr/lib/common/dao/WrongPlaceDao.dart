
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
/**
 * 位置錯誤 dao
 * Date: 2014-04-28
 */
class WrongPlaceDao {
  ///無對應
  static getQueryNoNode() async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryNoNodeAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryNoNode resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
        return new DataResult(mainDataArray, true);
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///無對應刷新
  static getRefreshData({custNo}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getRefreshDataAPI('WrongPlace', custNo), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getRefreshData resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
        return new DataResult(mainDataArray, true);
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///位置錯誤 - 詳情頁
  static getQueryWrongPlaceDetail({page}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryWrongPlaceDetailAPI(page), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryWrongPlaceDetail resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        if (res.data["ReturnData"].length == 0) {
          return new DataResult(null, false);
        }
        else {
          mainDataArray = res.data["ReturnData"];
          return new DataResult(mainDataArray, true);
        }
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///位置錯誤 - Node列表
  static getQueryWrongPlaceList({page}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryWrongPlaceListAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryWrongPlaceList resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        if (res.data["ReturnData"].length == 0) {
          return new DataResult(null, false);
        }
        else {
          mainDataArray = res.data["ReturnData"];
          return new DataResult(mainDataArray, true);
        }
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
}