import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
/**
 * 設定Dao
 */
class SettingDao {
  ///取得cmts列表
  static getQueryJumpFreqCMTS() async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryJumpFreqCMTSAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryJumpFreqCMTS resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///取得時間
  static getQuerySwitchDelayTime() async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQuerySwitchDelayTimeAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQuerySwitchDelayTime resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///取得設定時間
  static getQueryAutoFrequenceTime() async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryAutoFrequenceTimeAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryAutoFrequenceTime resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///更新switch時間
  static postUploadSwitchFreq({cmts, cif, accName, delay}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.postUploadSwitchFreqAPI(cmts, cif, accName, delay), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryJumpFreqCIF resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///取得跳頻cif
  static getQueryJumpFreqCIF({cType}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryJumpFreqCIFAPI(cType), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryJumpFreqCIF resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///設定自動時間
  static setAutoFrequenceTime({time1, time2, time3, time4}) async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.setAutoFrequenceTimeAPI(time1, time2, time3, time4), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryJumpFreqCIF resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///取得跳頻log
  static getQueryJumpFreqLOG() async {
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryJumpFreqLOGAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryJumpFreqLOG resp => " + res.data.toString());
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
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }

}