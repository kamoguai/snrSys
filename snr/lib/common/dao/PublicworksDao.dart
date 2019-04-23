
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';

class PublicworksDao {

  ///工務異常list
  static getQueryOverTimeAnalyse() async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(Address.getPublicworksAnalyseAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryOverTimeAnalyse resp => " + res.data.toString());
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
  ///工務詳情
  static getQueryWorkWarning(Store store, {type, city, sort, hub}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryWorkWarningAPI(type, city, sort, hub), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryWorkWarning resp => " + res.data.toString());
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