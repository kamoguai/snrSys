// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BpTableCell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BpTableCell _$BpTableCellFromJson(Map<String, dynamic> json) {
  return BpTableCell(
      json['Name'] as String,
      json['CustNo'] as String,
      json['N_COID'] as String,
      json['Address'] as String,
      json['InstallMan'] as String,
      json['InstallDate'] as String,
      json['SaleMan'] as String,
      json['note6'] as String,
      json['note6_color'] as String,
      json['note7'] as String,
      json['Target'] == false ? "" : json['Target'] as String,
      json['YearMonth'] as String,
      json['WorkDate'] as String,
      json['WorkInfo'] as String,
      json['WorkMan'] as String,
      json['fixDate'] as String,
      json['Building'] as String,
      json['CustClass'] as String,
      json['ReportLog'] as String,
      json['ReportLogColor'] as String,
      json['BossLog'] as String,
      json['BossLogColor'] as String,
      json['RealNodePath'] as String,
      json['BossNodePath'] as String);
}

Map<String, dynamic> _$BpTableCellToJson(BpTableCell instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'CustNo': instance.CustNo,
      'N_COID': instance.N_COID,
      'Address': instance.Address,
      'InstallMan': instance.InstallMan,
      'InstallDate': instance.InstallDate,
      'SaleMan': instance.SaleMan,
      'note6': instance.note6,
      'note6_color': instance.note6_color,
      'note7': instance.note7,
      'Target': instance.Target,
      'YearMonth': instance.YearMonth,
      'WorkDate': instance.WorkDate,
      'WorkInfo': instance.WorkInfo,
      'WorkMan': instance.WorkMan,
      'fixDate': instance.fixDate,
      'Building': instance.Building,
      'CustClass': instance.CustClass,
      'ReportLog': instance.ReportLog,
      'ReportLogColor': instance.ReportLogColor,
      'BossLog': instance.BossLog,
      'BossLogColor': instance.BossLogColor,
      'RealNodePath': instance.RealNodePath,
      'BossNodePath': instance.BossNodePath
    };
