import 'package:json_annotation/json_annotation.dart';

part 'HomeSignal.g.dart';

@JsonSerializable()
class SignalData {
  String Name; //區域

  String CMTSCode; //區域code

  String OnLine; //上線

  String OffLine; //下線

  String Bad; //異常

  String Low;

  String Time;//資料時間

  double BadRate; //重大

  String Problem; //問題

  String OverPower; //上Ｐ

  String AssignFix; //派修

  String VBAD; //可異

  SignalData(
      this.Name,
      this.CMTSCode,
      this.OnLine,
      this.OffLine,
      this.Bad,
      this.Low,
      this.Time,
      this.BadRate,
      this.Problem,
      this.OverPower,
      this.AssignFix,
      this.VBAD);


      // 反序列化
   factory SignalData.fromJson(Map<String, dynamic> json) => _$SignalDataFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$SignalDataToJson(this);

   // 命名構造函數
   SignalData.empty();
}
