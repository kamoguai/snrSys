// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BigBad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bigbad _$BigbadFromJson(Map<String, dynamic> json) {
  return Bigbad(
      json['Name'] as String,
      json['CIF'] as String,
      json['Online'] as String,
      json['Bad'] as String,
      json['VBAD'] as String,
      json['FIX'] as String,
      json['DATE'] as String,
      json['Time'] as String,
      json['UTIME_COLOR'] as String,
      json['RTIME'] as String,
      json['RTIME_COLOR'] as String,
      json['DisplayName'] as String);
}

Map<String, dynamic> _$BigbadToJson(Bigbad instance) => <String, dynamic>{
      'Name': instance.Name,
      'CIF': instance.CIF,
      'Online': instance.Online,
      'Bad': instance.Bad,
      'VBAD': instance.VBAD,
      'FIX': instance.FIX,
      'DATE': instance.DATE,
      'Time': instance.Time,
      'UTIME_COLOR': instance.UTIME_COLOR,
      'RTIME': instance.RTIME,
      'RTIME_COLOR': instance.RTIME_COLOR,
      'DisplayName': instance.DisplayName
    };
