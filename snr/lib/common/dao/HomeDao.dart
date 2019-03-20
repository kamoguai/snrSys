import 'package:dio/dio.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/model/HomeCmtsTitleInfo.dart';

class HomeDao {
  ///取得首頁cmtsTitleInfo筆數
  static getQueryCMTSMainTitleInfoAPI() async {
    next() async {
      Map<String, dynamic> mainDataArray = {};
      Map<String, dynamic> dataArray = {};
      var res = await HttpManager.netFetch(
          Address.getQueryCMTSMainTitleInfoAPI(),
          null,
          null,
          new Options(method: "post"));

      if (res != null && res.result) {
        if (Config.DEBUG) {
          print("首頁cmtsTitleInfo resp => " + res.data.toString());
        }
        if (res.data['Response']['ReturnCode'] == "0") {
          mainDataArray = res.data["ReturnData"];
        }
        if (mainDataArray.length > 0) {
          dataArray = mainDataArray["Data"];
          CmtsTitleInfo ctInfo = CmtsTitleInfo.fromJson(dataArray);
          return new DataResult(ctInfo, true);
        }
        else {
          return new DataResult(null, false);
        }
      }
      else {
        return new DataResult(null, false);
      }
    }
    return await next();
  }
}
