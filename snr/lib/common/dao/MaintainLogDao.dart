import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/net/Address.dart';
/**
 * 維修記錄 dao
 * Date: 2019-05-09
 */
class MaintainLogDao {
  ///取得維修記錄log
  static getHipassLogData({custNo}) async {
    Map<String,dynamic> mainDataArray = new Map<String,dynamic>();
    var res = await HttpManager.netFetch(Address.getHipassLogDataAPI(custNo), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getHipassLogData resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      if (mainDataArray != null && mainDataArray.length > 0) {
        return new DataResult(mainDataArray, true);
      } else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///清除維修記錄
  static delReportLog({senderId, senderName, logIdList, custId, from}) async {
    var res = await HttpManager.netFetch(Address.delReportLog(senderId, senderName, logIdList, custId, from), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("delReportLog resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(res, true);
      }
      else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
  ///添加維修記錄
  static addDescription({custId, inputText, senderId, senderName, from}) async{
    var res = await HttpManager.netFetch(Address.addDescriptionAPI(custId, inputText, senderId, senderName, from), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("delReportLog resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(res, true);
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