import 'package:json_annotation/json_annotation.dart';

part 'FinishedTableCell.g.dart';
/**
 * Date: 2019-04-02
 */
@JsonSerializable()
class FinishedTableCell {
  String Address;
  String CustNo;
  String note1;
  String note1_color;
  String CustClass;
  String Name;
  String FinishedTime;
  String Fix2Time;
  String FinishedTime2;
  String ReportLog;
  String ReportLogColor;


  FinishedTableCell(
   this.Address,
   this.CustNo,
   this.note1,
   this.note1_color,
   this.CustClass,
   this.Name,
   this.FinishedTime,
   this.Fix2Time,
   this.FinishedTime2,
   this.ReportLog,
   this.ReportLogColor,

  );
  
  FinishedTableCell.empty();

  factory FinishedTableCell.fromJson(Map<String, dynamic> json) => _$FinishedTableCellFromJson(json);

  Map<String, dynamic> toJson() => _$FinishedTableCellToJson(this);

}