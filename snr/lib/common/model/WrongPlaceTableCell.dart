import 'package:json_annotation/json_annotation.dart';

part 'WrongPlaceTableCell.g.dart';

@JsonSerializable()
class WrongPlaceTableCell {
  String Address;//地址
  String CustNo;//客編
  String InstallDate;//裝機時間
  String Name;//客名
  String note6;//雙分:單分
  int Status;//狀態
  String InstallMan;//裝機人
  String BB;//網速
  String CustClass;//大樓
  String RealNodePath;//真實位置
  String BossNodePath;//boss位置

  WrongPlaceTableCell(
    this.Address,//地址
    this.CustNo,//客編
    this.InstallDate,//裝機時間
    this.Name,//客名
    this.note6,//雙分:單分
    int Status,//狀態
    this.InstallMan,//裝機人
    this.BB,//網速
    this.CustClass,//大樓
    this.RealNodePath,//真實位置
    this.BossNodePath,//boss位置
  );
  // 反序列化
   factory WrongPlaceTableCell.fromJson(Map<String, dynamic> json) => _$WrongPlaceTableCellFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$WrongPlaceTableCellToJson(this);

   // 命名構造函數
   WrongPlaceTableCell.empty();
}