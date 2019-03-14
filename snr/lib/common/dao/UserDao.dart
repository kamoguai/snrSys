import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/config/Config.dart';
import 'package:snr/common/net/Api.dart';
import 'package:snr/common/net/Address.dart';
import 'package:dio/dio.dart';
import 'package:snr/common/redux/UserRedux.dart';
import 'package:snr/common/dao/DaoResult.dart';
import 'package:snr/common/model/User.dart';
import 'package:snr/common/ab/provider/user/UserInfoDbProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDao {
  static login(account, password, store) async {
    await LocalStorage.save(Config.USER_NAME_KEY, account);
    Map requestParams = {
      "accNo":account,
      "passWord":password,
    };
    HttpManager.clearAuthorization();

    var res = await HttpManager.netFetch(Address.ssoLoginAPI(account, password), json.encode(requestParams), null, new Options(method: "post"));
    var resultData = null;
    if (res != null && res.result) {
      if (res.data["retCode"] != "00") {
        Fluttertoast.showToast(msg: res.data["retMSG"]);
        return new DataResult(null, false);
      }
      await LocalStorage.save(Config.PW_KEY, password);
      var serviceUrl = res.data["serverURL"];
      var ssoKey = res.data["ssoKey"];
      var resultData = await getUserInfo(serviceUrl, account, ssoKey);
      if (Config.DEBUG) {
        print(resultData.data);
        print(res.data.toString());
      }
      store.dispatch(new UpdateUserAction(resultData.data));
    }
    return new DataResult(resultData, res.result);
  }

   ///獲取本地登入用戶信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  ///獲取用戶詳細信息
  static getUserInfo(serviceURL, account, ssoKey, {needDb = false}) async {
    UserInfoDbProvider provider = new UserInfoDbProvider();
    Map<String, dynamic> mainDataArray = {};
    next() async {
      var res;
      if (account == null) {
        print("account不可能為null吧？");
        // res = await HttpManager.netFetch(Address.getMyUserInfo(), null, null, null);
      } else {
        res = await HttpManager.netFetch(Address.snrLoginAPI(serviceURL, account, ssoKey), null, null, null);
      }
      if (res != null && res.result) {
        print("returnCode -> "+res.data['Response']['ReturnCode']);

        if (res.data['Response']['ReturnCode'] == "0") {
          mainDataArray = res.data["ReturnData"];
        }
        // if (mainDataArray.length > 0 ) {
          User user = User.fromJson(mainDataArray);
          if (account == null) {
            LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
          }
          else {
            if (needDb) {
              provider.insert(account, json.encode(user.toJson()));
            }
          }
          return new DataResult(user, true);
        // }
        /*
        String starred = "---";
        if (res.data["type"] != "Organization") {
          var countRes = await getUserStaredCountNet(res.data["login"]);
          if (countRes.result) {
            starred = countRes.data;
          }
        }
        User user = User.fromJson(res.data);
        user.starred = starred;
        if (userName == null) {
          LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        } else {
          if (needDb) {
            provider.insert(userName, json.encode(user.toJson()));
          }
        }
        return new DataResult(user, true);
        */
      } else {
        return new DataResult(res.data, false);
      }
    }

    if (needDb) {
      User user = await provider.getUserInfo(account);
      if (user == null) {
        return await next();
      }
      DataResult dataResult = new DataResult(user, true, next: next());
      return dataResult;
    }
    return await next();
    
  }

  static initUserInfo(Store store) async {
    var res = await getUserInfoLocal();
    if (res != null && res.result) {
      store.dispatch(UpdateUserAction(res.data));
    }
    return new DataResult(res.data, (res.result));
  }
}