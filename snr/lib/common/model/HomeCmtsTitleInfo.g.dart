// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeCmtsTitleInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CmtsTitleInfo _$CmtsTitleInfoFromJson(Map<String, dynamic> json) {
  return CmtsTitleInfo(
      json['MAJOR'] == null ? "0" : json["MAJOR"] as String,
      json['CH'] == null ? "0" : json["CH"] as String,
      json['SNR'] == null ? "0" : json["SNR"] as String,
      json['IN'] == null ? "0" : json["IN"] as String,
      json['OUT'] == null ? "0" : json["OUT"] as String,
      json['TRACK'] == null ? "0" : json["TRACK"] as String,
      json['HP'] == null ? "0" : json["HP"] as String,
      json['LHP'] == null ? "0" : json["LHP"] as String,
      json['PIPE'] == null ? "0" : json["PIPE"] as String,
      json['VBAD'] == null ? "0" : json["VBAD"] as String,
      json['FIX'] == null ? "0" : json["FIX"] as String,
      json['WorkWarning'] == null ? "0" : json["WorkWarning"] as String,
      json['SIGNAL'] == null ? "0" : json["SIGNAL"] as String);
}

Map<String, dynamic> _$CmtsTitleInfoToJson(CmtsTitleInfo instance) =>
    <String, dynamic>{
      'MAJOR': instance.MAJOR,
      'CH': instance.CH,
      'SNR': instance.SNR,
      'IN': instance.IN,
      'OUT': instance.OUT,
      'TRACK': instance.TRACK,
      'HP': instance.HP,
      'LHP': instance.LHP,
      'PIPE': instance.PIPE,
      'VBAD': instance.VBAD,
      'FIX': instance.FIX,
      'WorkWarning': instance.WorkWarning,
      'SIGNAL': instance.SIGNAL
    };
