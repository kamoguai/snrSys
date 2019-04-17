import 'package:json_annotation/json_annotation.dart';
import 'package:snr/common/model/CodeWordModel.dart';
import 'package:snr/common/model/SNRModel.dart';
part 'SmallPingTableCell.g.dart';

/**
 * Date: 2019-04-17
 */
@JsonSerializable()
class SmallPingTableCell {
  String CMTS;
  String CIF;
  String NODE;
  String CustCode;
  Map<String,dynamic> COUNT;
  String ONLINETIME;
  String CMSWVER;
  String CustName;
  String BB;
  String BuildingName;
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
  String STATUS;
  String PINGTIME;
  String note1;
  String note1_color;
  String note2;
  String note2_color;
  String note3;
  String note3_color;
  String note4;
  String note4_color;
  String note5;
  String note5_color;
  String USFLOW;
  String DSFLOW;
  String Response;
  String PacketLoss;

  Map<String,dynamic> SNR;
  Map<String,dynamic> CodeWord;

  SmallPingTableCell(
    this.CMTS,
    this.CIF,
    this.NODE,
    this.CustCode,
    this.COUNT,
    this.ONLINETIME,
    this.CMSWVER,
    this.CustName,
    this.BB,
    this.BuildingName,
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
    this.STATUS,
    this.PINGTIME,
    this.note1,
    this.note1_color,
    this.note2,
    this.note2_color,
    this.note3,
    this.note3_color,
    this.note4,
    this.note4_color,
    this.note5,
    this.note5_color,
    this.USFLOW,
    this.DSFLOW,
    this.Response,
    this.PacketLoss,
    this.CodeWord,
    this.SNR
  );


  factory SmallPingTableCell.fromJson(Map<String, dynamic> json) => _$SmallPingTableCellFromJson(json);
  Map<String, dynamic> toJson() => _$SmallPingTableCellToJson(this);



}