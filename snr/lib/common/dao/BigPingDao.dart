import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/net/Address.dart';
/**
 * 大PING dao
 * Date: 2019-05-08
 */
class BigPingDao {
  ///cpe資料
  static getCPEData({cmts, cmmac}) async {
    List<dynamic> mainDataArray = new List<dynamic>();
    var res = await HttpManager.netFetch(Address.getCPEDataAPI(cmts, cmmac), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getCPEData resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      if (mainDataArray.length > 0) {
        return new DataResult(mainDataArray, true);
      } else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///flap資料
  static getFLAPData({cmts, cmmac}) async {
    Map<String,dynamic> mainDataArray = new Map<String,dynamic>();
    var res = await HttpManager.netFetch(Address.getFLAPDataAPI(cmts, cmmac), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getFLAPData resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      if (mainDataArray.length > 0) {
        return new DataResult(mainDataArray, true);
      } else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///清除flap資料
  static clearFLAPData({cmts, cmmac}) async {
    Map<String,dynamic> mainDataArray = new Map<String,dynamic>();
    var res = await HttpManager.netFetch(Address.clearFLAPDataAPI(cmts, cmmac), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("clearFLAPData resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["Response"];
      }
      if (mainDataArray.length > 0) {
        return new DataResult(mainDataArray, true);
      } else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
}