import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
   String login; // 登入狀態
   String accNo; // 帳號
   String passWord; // 密碼
   String accName; // 使用者名
   int isConfig; // 能否使用修改設定值權限
   int isJump; // 能否使用跳頻權限
   int isTransfer; // 能否使用跳轉權限
   int isCMReset; // 能否使用關閉CM權限
   int isCMRestart; // 能否使用重啟CM權限
   int isDeleteReportLog; // 能否使用刪除回報log權限
   int isAssign; // 能否使用指派人員權限
   int isTransFromDeduct; // 能否使用扣點跳轉權限
   int isTransFromDeduct1ToGood; // 能否使用扣點跳轉至正常權限
   int isTransFromDeduct1ToDeduct2; // 能否使用跳轉至扣點權限
   int isTransFromWP1; // 能否使用位置錯誤跳轉權限
   int isTransFromWP2; // 能否使用自移跳轉權限
   int isTransFromWP3; // 能否使用停訊跳轉權限

   User(
     this.login,
     this.accNo,
     this.passWord,
     this.accName,
     this.isConfig,
     this.isJump,
     this.isTransfer,
     this.isAssign,
     this.isCMReset,
     this.isCMRestart,
     this.isDeleteReportLog,
     this.isTransFromDeduct,
     this.isTransFromDeduct1ToDeduct2,
     this.isTransFromDeduct1ToGood,
     this.isTransFromWP1,
     this.isTransFromWP2,
     this.isTransFromWP3
   );
   // 反序列化
   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$UserToJson(this);

   // 命名構造函數
   User.empty();
}