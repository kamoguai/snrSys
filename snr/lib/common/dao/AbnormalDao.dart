import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';

class AbnormalDao {
  /// abnormalCardPage
  static getSNRSignalByCMTS(cmtsCode) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(
        Address.getSNRSignalByCMTSAPI(cmtsCode),
        null,
        null,
        new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getSNRSignalByCMTS resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
      if (mainDataArray.length > 0) {
        // dataArray = mainDataArray["Data"];

        return new DataResult(mainDataArray, true);
      } else {
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///abnormalCardPage
  static getSNRSignalByCmtsAndCif(cmtsCode, cif) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = await HttpManager.netFetch(
        Address.getSNRSignalByCmtsAndCifAPI(cmtsCode, cif),
        null,
        null,
        new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getSNRSignalByCmtsAndCif resp => " + res.data.toString());
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
