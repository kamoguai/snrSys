import 'package:json_annotation/json_annotation.dart';
part 'CodeWord.g.dart';
/**
 * Date: 2019-04-02
 */
@JsonSerializable()
class CodeWord {
  String U;
  String C;

  CodeWord(this.C, this.U);
  factory CodeWord.fromJson(Map<String, dynamic> json) => _$CodeWordFromJson(json);

  Map<String, dynamic> toJson() => _$CodeWordToJson(this);
}