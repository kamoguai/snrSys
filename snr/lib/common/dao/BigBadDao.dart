import 'package:dio/dio.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/model/BigBad.dart';
class BigbadDao {

  static getQueryBigBadAPI() async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataArray = [];
    List<Bigbad> list = new List();
    var res = await HttpManager.netFetch(Address.getQueryBigBad(), null, null, new Options(method: "post"));

    if (res != null && res.result) {
      if (Config.DEBUG) {
        print("首頁bigbad resp => " + res.data.toString());
      }
      if (res.data['Response']['ReturnCode'] == "0") {
        mainDataArray = res.data["ReturnData"];
      }
      if (mainDataArray.length > 0) {
        dataArray = mainDataArray["Data"];
        if (dataArray.length > 0) {
          for (var dic in dataArray) {
            list.add(new Bigbad.fromJson(dic));
          }
        }
        return new DataResult(list, true);
      } else {
        return new DataResult(null, false);
      }
    } else {
      return new DataResult(null, false);
    }
  }
}

