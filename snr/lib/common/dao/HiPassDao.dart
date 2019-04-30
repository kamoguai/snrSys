import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
/**
 * 鎖HP dao
 * Date: 2014-04-30
 */
class HiPassDao {
  ///鎖HP列表
  static getHiBuildAnalys() async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> dataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryHiPassAnalyseAPI(), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getHiBuildAnalys resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
        if (mainDataArray != null && mainDataArray.length > 0) {
          dataArray = mainDataArray["Data"];
        }
        return new DataResult(dataArray, true);
      }
      else {
        Fluttertoast.showToast(msg: res.data['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    } 
  }
  ///鎖HP詳情
  static getQueryHiPASS({strHiPass, area, sort, hub}) async{
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getQueryHiPASSAPI(strHiPass, area, sort, hub), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getHiBuildAnalys resp => " + res.data.toString());
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
}