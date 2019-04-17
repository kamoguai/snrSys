import 'package:json_annotation/json_annotation.dart';
part 'CodeWordModel.g.dart';
/**
 * Date: 2019-04-17
 */
@JsonSerializable()
class CodeWordModel {
  String CodeWord;
  String U0;
  String C;
  String U;
  String U1;
  String U2;
  String U3;
  List<CodeWordModel> parents;

  CodeWordModel(
    this.CodeWord,
    this.U0,
    this.U1,
    this.U2,
    this.U3,
    this.C,
    this.U,
    this.parents
  );
  factory CodeWordModel.fromJson(Map<String, dynamic> json) => _$CodeWordModelFromJson(json);
  Map<String, dynamic> toJson() => _$CodeWordModelToJson(this);
}
