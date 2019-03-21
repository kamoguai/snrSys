// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeSignal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalData _$SignalDataFromJson(Map<String, dynamic> json) {
  return SignalData(
      json['Name'] as String,
      json['CMTSCode'] as String,
      json['OnLine'] as String,
      json['OffLine'] as String,
      json['Bad'] as String,
      json['Low'] as String,
      json['Time'] == false ? "" : json['Time'] as String,
      (json['BadRate'] as num)?.toDouble(),
      json['Problem'] as String,
      json['OverPower'] as String,
      json['AssignFix'] as String,
      json['VBAD'] as String);
}

Map<String, dynamic> _$SignalDataToJson(SignalData instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'CMTSCode': instance.CMTSCode,
      'OnLine': instance.OnLine,
      'OffLine': instance.OffLine,
      'Bad': instance.Bad,
      'Low': instance.Low,
      'Time': instance.Time,
      'BadRate': instance.BadRate,
      'Problem': instance.Problem,
      'OverPower': instance.OverPower,
      'AssignFix': instance.AssignFix,
      'VBAD': instance.VBAD
    };
