import 'package:json_annotation/json_annotation.dart';
part 'SNRModel.g.dart';
/**
 * Date: 2019-04-17
 */
@JsonSerializable()
class SNRModel {

  String SNR;
  String PWR;
  String U0;
  String U1;
  String U2;
  String U3;

  List<SNRModel> parents;

  SNRModel(
    this.SNR,
    this.PWR,
    this.U0,
    this.U1,
    this.U2,
    this.U3,
    this.parents
  );
  factory SNRModel.fromJson(Map<String, dynamic> json) => _$SNRModelFromJson(json);
  Map<String, dynamic> toJson() => _$SNRModelToJson(this);
}