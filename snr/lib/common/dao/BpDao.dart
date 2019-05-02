
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
/**
 * 扣點dao
 * Date: 2014-03-20
 */
class BpDao {
  ///待確認，扣點
  static getQueryDeductDetail({yeaMonth, page}) async{
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryDeductDetailAPI(yeaMonth, page), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryDeductDetail resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
        return new DataResult(mainDataArray, true);
      }
      else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///扣點統計
  static getQueryDeductAnalyse({yeaMonth}) async{
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryDeductAnalyseAPI(yeaMonth), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getQueryDeductAnalyse resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
        return new DataResult(mainDataArray, true);
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