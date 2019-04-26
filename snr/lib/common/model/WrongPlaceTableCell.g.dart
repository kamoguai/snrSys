// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WrongPlaceTableCell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrongPlaceTableCell _$WrongPlaceTableCellFromJson(Map<String, dynamic> json) {
  return WrongPlaceTableCell(
      json['Address'] as String,
      json['CustNo'] as String,
      json['InstallDate'] as String,
      json['Name'] as String,
      json['note6'] as String,
      json['Status'] as int,
      json['InstallMan'] as String,
      json['BB'] as String,
      json['CustClass'] as String,
      json['RealNodePath'] as String,
      json['BossNodePath'] as String);
}

Map<String, dynamic> _$WrongPlaceTableCellToJson(
        WrongPlaceTableCell instance) =>
    <String, dynamic>{
      'Address': instance.Address,
      'CustNo': instance.CustNo,
      'InstallDate': instance.InstallDate,
      'Name': instance.Name,
      'note6': instance.note6,
      'Status': instance.Status,
      'InstallMan': instance.InstallMan,
      'BB': instance.BB,
      'CustClass': instance.CustClass,
      'RealNodePath': instance.RealNodePath,
      'BossNodePath': instance.BossNodePath
    };
