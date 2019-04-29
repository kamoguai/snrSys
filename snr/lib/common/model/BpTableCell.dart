
import 'package:json_annotation/json_annotation.dart';
part 'BpTableCell.g.dart';

@JsonSerializable()
class BpTableCell {
  String Name;//客戶名
  String CustNo;//客編
  String N_COID;//工單號
  String Address;//地址
  String InstallMan;//安裝人員
  String InstallDate;//安裝時間
  String SaleMan;//業務人員
  String note6;//note6
  String note6_color;//note6 color
  String note7;//note7
  String Target;
  String YearMonth;//資料年份
  String WorkDate;//實作日期
  String WorkInfo;//實作信息
  String WorkMan;//實作人員
  String fixDate;//維修時間
  String Building;//大樓名稱
  String CustClass;//大樓名稱
  String ReportLog;//工程回報
  String ReportLogColor;//工程回報color
  String BossLog;//boss信息
  String BossLogColor;//boss color
  String RealNodePath;//真實路徑
  String BossNodePath;//boss路徑

  BpTableCell(
    this.Name,//客戶名
    this.CustNo,//客編
    this.N_COID,//工單號
    this.Address,//地址
    this.InstallMan,//安裝人員
    this.InstallDate,//安裝時間
    this.SaleMan,//業務人員
    this.note6,//note6
    this.note6_color,//note6 color
    this.note7,//note7
    this.Target,
    this.YearMonth,//資料年份
    this.WorkDate,//實作日期
    this.WorkInfo,//實作信息
    this.WorkMan,//實作人員
    this.fixDate,//維修時間
    this.Building,//大樓名稱
    this.CustClass,//大樓名稱
    this.ReportLog,//工程回報
    this.ReportLogColor,//工程回報color
    this.BossLog,//boss信息
    this.BossLogColor,//boss color
    this.RealNodePath,//真實路徑
    this.BossNodePath,//boss路徑
  );
  // 反序列化
   factory BpTableCell.fromJson(Map<String, dynamic> json) => _$BpTableCellFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$BpTableCellToJson(this);

   // 命名構造函數
   BpTableCell.empty();
}