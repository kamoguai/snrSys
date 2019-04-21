
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';

class PublicworksDao {

  ///工務異常list
  static getQueryOverTimeAnalyse() async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    var res = HttpManager.netFetch(Address.getPublicworksAnalyseAPI, null, null, new Options(method: "post"));
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