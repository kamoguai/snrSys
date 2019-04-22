import 'package:json_annotation/json_annotation.dart';

part 'PublicworksTableCell.g.dart';
/**
 * 工務詳情cell
 * Date: 2019-04-22
 */
@JsonSerializable()
class PublicworksTableCell {
  String Address;
  String InstallMan;
  String InstallDate;
  String SaleMan;
  String WorkInfo;
  String WorkDate;
  String WorkMan;
  String RealNodePath;
  String note6;
  String note6_color;
  String fixDate;
  String AssignMan;
  String BossNodePath;
  String OTIME;
  String CustNo;
  String note1;
  String note1_color;
  String CustClass;
  String Name;
  String isMarjor;
  String RestartCount;
  String RestartTime;
  String U0_SNR;
  String U1_SNR;
  String U2_SNR;
  String U3_SNR;
  String U0_PWR;
  String U1_PWR;
  String U2_PWR;
  String U3_PWR;
  String DS0;
  String DS1;
  String DS2;
  String DS3;
  String DS4;
  String DS5;
  String DS6;
  String DS7;
  String DP0;
  String DP1;
  String DP2;
  String DP3;
  String DP4;
  String DP5;
  String DP6;
  String DP7;
  int Status;
  String BB;
  String note2;
  String note2_color;
  String note3;
  String note3_color;
  String note4;
  String note4_color;
  String note5;
  String note5_color;
  String note7;
  String note7_color;
  String DataTime2;
  String USFLOW;
  String DSFLOW;
  String Response;
  String PacketLoss;
  String ReportLog;
  String ReportLogColor;
  String BossLog;
  String BossLogColor;
  String U0C;
  String U0U;
  String U1C;
  String U1U;
  String U2C;
  String U2U;
  String U3C;
  String U3U;
  String N_COID;
  String Target;
  String YearMonth;
  String wkNo;


  PublicworksTableCell(
   this.Address,
   this.InstallMan,
   this.InstallDate,
   this.SaleMan,
   this.WorkInfo,
   this.WorkDate,
   this.WorkMan,
   this.RealNodePath,
   this.note6,
   this.note6_color,
   this.fixDate,
   this.AssignMan,
   this.BossNodePath,
   this.OTIME,
   this.CustNo,
   this.note1,
   this.note1_color,
   this.CustClass,
   this.Name,
   this.isMarjor,
   this.RestartCount,
   this.RestartTime,
   this.U0_SNR,
   this.U1_SNR,
   this.U2_SNR,
   this.U3_SNR,
   this.U0_PWR,
   this.U1_PWR,
   this.U2_PWR,
   this.U3_PWR,
   this.DS0,
   this.DS1,
   this.DS2,
   this.DS3,
   this.DS4,
   this.DS5,
   this.DS6,
   this.DS7,
   this.DP0,
   this.DP1,
   this.DP2,
   this.DP3,
   this.DP4,
   this.DP5,
   this.DP6,
   this.DP7,
   this.Status,
   this.BB,
   this.note2,
   this.note2_color,
   this.note3,
   this.note3_color,
   this.note4,
   this.note4_color,
   this.note5,
   this.note5_color,
   this.note7,
   this.note7_color,
   this.DataTime2,
   this.USFLOW,
   this.DSFLOW,
   this.Response,
   this.PacketLoss,
   this.ReportLog,
   this.ReportLogColor,
   this.BossLog,
   this.BossLogColor,
   this.U0C,
   this.U0U,
   this.U1C,
   this.U1U,
   this.U2C,
   this.U2U,
   this.U3C,
   this.U3U,
   this.N_COID,
   this.Target,
   this.YearMonth,
   this.wkNo,
  );
  
  PublicworksTableCell.empty();

  factory PublicworksTableCell.fromJson(Map<String, dynamic> json) => _$PublicworksTableCellFromJson(json);

  Map<String, dynamic> toJson() => _$PublicworksTableCellToJson(this);

}