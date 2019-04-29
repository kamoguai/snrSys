

import 'package:json_annotation/json_annotation.dart';
part 'BpAnalyzeTableCell.g.dart';

@JsonSerializable()
class BpAnalyzeTableCell {
  String Name;//人員
  String Inst;//裝機
  String Fix;//維修
  String Total;//小計
  String Points;//扣點數

  BpAnalyzeTableCell(
    this.Name,//人員
    this.Inst,//裝機
    this.Fix,//維修
    this.Total,//小計
    this.Points,//扣點數

  );
  // 反序列化
  factory BpAnalyzeTableCell.fromJson(Map<String, dynamic> json) => _$BpAnalyzeTableCellFromJson(json);
  // 序列化
  Map<String, dynamic> toJson() => _$BpAnalyzeTableCellToJson(this);

  // 命名構造函數
  BpAnalyzeTableCell.empty();

}