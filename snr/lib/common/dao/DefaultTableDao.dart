

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/utils/CommonUtils.dart';

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
}