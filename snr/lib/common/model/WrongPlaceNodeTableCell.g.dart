// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WrongPlaceNodeTableCell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrongPlaceNodeTableCell _$WrongPlaceNodeTableCellFromJson(
    Map<String, dynamic> json) {
  return WrongPlaceNodeTableCell(
      json['NodePath'] as String,
      json['Node'] as String,
      json['BossLC'] as String,
      json['BossCount'] as String,
      json['RealLC'] as String,
      json['RealCount'] as String);
}

Map<String, dynamic> _$WrongPlaceNodeTableCellToJson(
        WrongPlaceNodeTableCell instance) =>
    <String, dynamic>{
      'NodePath': instance.NodePath,
      'Node': instance.Node,
      'BossLC': instance.BossLC,
      'BossCount': instance.BossCount,
      'RealLC': instance.RealLC,
      'RealCount': instance.RealCount
    };
