// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BpAnalyzeTableCell.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BpAnalyzeTableCell _$BpAnalyzeTableCellFromJson(Map<String, dynamic> json) {
  return BpAnalyzeTableCell(json['Name'] as String, json['Inst'] as String,
      json['Fix'] as String, json['Total'] as String, json['Points'] as String);
}

Map<String, dynamic> _$BpAnalyzeTableCellToJson(BpAnalyzeTableCell instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'Inst': instance.Inst,
      'Fix': instance.Fix,
      'Total': instance.Total,
      'Points': instance.Points
    };
