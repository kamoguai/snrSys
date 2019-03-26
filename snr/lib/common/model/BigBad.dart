import 'package:json_annotation/json_annotation.dart';
part 'BigBad.g.dart';

@JsonSerializable()
class Bigbad {
  String Name;
  String CIF;
  String Online;
  String Bad;
  String VBAD;
  String FIX;
  String DATE;
  String Time;
  String UTIME_COLOR;
  String RTIME;
  String RTIME_COLOR;
  String DisplayName;

  Bigbad(
    this.Name,
    this.CIF,
    this.Online,
    this.Bad,
    this.VBAD,
    this.FIX,
    this.DATE,
    this.Time,
    this.UTIME_COLOR,
    this.RTIME,
    this.RTIME_COLOR,
    this.DisplayName
  );
  // 反序列化
   factory Bigbad.fromJson(Map<String, dynamic> json) => _$BigbadFromJson(json);
   // 序列化
   Map<String, dynamic> toJson() => _$BigbadToJson(this);

   // 命名構造函數
   Bigbad.empty();
}