// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['login'] as String,
      json['accNo'] as String,
      json['passWord'] as String,
      json['accName'] as String,
      json['isConfig'] as int,
      json['isJump'] as int,
      json['isTransfer'] as int,
      json['isAssign'] as int,
      json['isCMReset'] as int,
      json['isCMRestart'] as int,
      json['isDeleteReportLog'] as int,
      json['isTransFromDeduct'] as int,
      json['isTransFromDeduct1ToDeduct2'] as int,
      json['isTransFromDeduct1ToGood'] as int,
      json['isTransFromWP1'] as int,
      json['isTransFromWP2'] as int,
      json['isTransFromWP3'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'accNo': instance.accNo,
      'passWord': instance.passWord,
      'accName': instance.accName,
      'isConfig': instance.isConfig,
      'isJump': instance.isJump,
      'isTransfer': instance.isTransfer,
      'isCMReset': instance.isCMReset,
      'isCMRestart': instance.isCMRestart,
      'isDeleteReportLog': instance.isDeleteReportLog,
      'isAssign': instance.isAssign,
      'isTransFromDeduct': instance.isTransFromDeduct,
      'isTransFromDeduct1ToGood': instance.isTransFromDeduct1ToGood,
      'isTransFromDeduct1ToDeduct2': instance.isTransFromDeduct1ToDeduct2,
      'isTransFromWP1': instance.isTransFromWP1,
      'isTransFromWP2': instance.isTransFromWP2,
      'isTransFromWP3': instance.isTransFromWP3
    };
