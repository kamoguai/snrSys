import 'package:json_annotation/json_annotation.dart';

part 'HomeCmtsTitleInfo.g.dart';

@JsonSerializable()
class CmtsTitleInfo {

  String MAJOR;//重大筆數
  String CH;
  String SNR;
  String IN;
  String OUT;
  String TRACK;//追蹤筆數
  String HP;//鎖HP
  String LHP; //低HP
  String PIPE;//區障
  String VBAD;//可異
  String FIX;//派修
  String WorkWarning;//工異
  String SIGNAL;//信號

  CmtsTitleInfo(
    this.MAJOR,
    this.CH,
    this.SNR,
    this.IN,
    this.OUT,
    this.TRACK,
    this.HP,
    this.LHP,
    this.PIPE,
    this.VBAD,
    this.FIX,
    this.WorkWarning,
    this.SIGNAL,
  );
  
   // 反序列化
   factory CmtsTitleInfo.fromJson(Map<String, dynamic> json) => _$CmtsTitleInfoFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$CmtsTitleInfoToJson(this);

   // 命名構造函數
   CmtsTitleInfo.empty();
}