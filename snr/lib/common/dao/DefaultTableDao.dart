

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/redux/SmallPingTableCellReducer.dart';
import 'package:snr/common/utils/CommonUtils.dart';
/**
 * 通用表dao
 * Date: 2014-03-20
 */
class DefaultTableDao {
  ///普通跳轉
  static didTransfer(context, {to, from, accNo, accName, custCDList}) async {
    var res = await HttpManager.netFetch(Address.didTransferAPI(to, from, accNo, accName, custCDList), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("didTransfer resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
      else {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
    }
    else {
      // return new DataResult(null, false);
    }
  }
  ///包含輸入匡跳轉
  static didTransferInputText(context, {to, from, memo, accNo, accName, custCDList}) async {
    var res = await HttpManager.netFetch(Address.didTransferInputTextAPI(to, from, memo, accNo, accName, custCDList), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("didTransfer resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
      else {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
    }
    else {
      // return new DataResult(null, false);
    }
  }
  ///工異專用
  static didTransferPublicwork(context, {to, from, memo, accNo, accName, jsonCustCD}) async{
    var res = await HttpManager.netFetch(Address.didTransferPublicworksAPI(to, from, memo, accNo, accName, jsonCustCD), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("didTransferPublicwork resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
      else {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
    }
    else {
      // return new DataResult(null, false);
    }
  }
  ///小ping
  static getPingSNR(Store store, context, {custCode}) async{
    Map<String, dynamic> mainDataArray = {};
    var res = await HttpManager.netFetch(Address.getPingSNR(custCode), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("getPingSNR resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      else {
        Fluttertoast.showToast(msg: res.data['Response']['MSG']);
        return new DataResult(null, false);
      }
      if (mainDataArray.length > 0) {
        store.dispatch(new RefreshSmallPingTableCellAction(SmallPingTableCell.fromJson(mainDataArray)));
        return new DataResult(mainDataArray, true);
      } else {
        return new DataResult(null, false);
      }
    }
    else {
      return new DataResult(null, false);
    }
  }
  ///執行關電
  static postResetCM(context, {cmts, custNo, accName}) async{
    var res = HttpManager.netFetch(Address.postResetCM(cmts, custNo, accName), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("postResetCM resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
      else {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
    }
    else {
      // return new DataResult(null, false);
    }
  }
  ///執行重啟
  static postRestartCM(context, {cmts, custNo, accName}) async{
    var res = HttpManager.netFetch(Address.postReStartCM(cmts, custNo, accName), null, null, new Options(method: "post"));
    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("postRestartCM resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
      else {
        CommonUtils.showMessageDialog(context, "", res.data['Response']['MSG']);
        // return new DataResult(null, false);
      }
    }
    else {
      // return new DataResult(null, false);
    }
  }
}