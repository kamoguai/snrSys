import 'package:snr/common/model/User.dart';
import 'package:redux/redux.dart';

/**
 * 用戶相關Redux
 * Date: 2019-03-11
 */
/// redux 的 combineReducers, 通過 TypedReducer 將 UpdateUserAction 與 reducers 關聯起來
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

/// 如果有 UpdateUserAction發請一個請求時
/// 就會調用到 _updateLoaded
/// _updateLoaded 這裡接受一個新的userInfo,並返回
User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

///定一個 UpdateUserAction, 用於發起 userInfo 的改變
///類名隨喜歡定義，只要通過上面TypedReducer綁定就好
class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}