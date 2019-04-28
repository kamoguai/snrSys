import 'package:json_annotation/json_annotation.dart';

part 'WrongPlaceNodeTableCell.g.dart';
@JsonSerializable()
class WrongPlaceNodeTableCell {

  String NodePath;//node路徑

  String Node;//node

  String BossLC;//boss光點

  String BossCount;//boss數量

  String RealLC;//實際光點

  String RealCount;//實際數量

  WrongPlaceNodeTableCell(
    
    this.NodePath,//node路徑

    this.Node,//node

    this.BossLC,//boss光點

    this.BossCount,//boss數量

    this.RealLC,//實際光點

    this.RealCount,//實際數量
  );
     // 反序列化
   factory WrongPlaceNodeTableCell.fromJson(Map<String, dynamic> json) => _$WrongPlaceNodeTableCellFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$WrongPlaceNodeTableCellToJson(this);

   // 命名構造函數
   WrongPlaceNodeTableCell.empty();
}