// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CodeWordModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeWordModel _$CodeWordModelFromJson(Map<String, dynamic> json) {
  return CodeWordModel(
      json['CodeWord'] as String,
      json['U0'] as String,
      json['U1'] as String,
      json['U2'] as String,
      json['U3'] as String,
      json['C'] as String,
      json['U'] as String,
      (json['parents'] as List)
          ?.map((e) => e == null
              ? null
              : CodeWordModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CodeWordModelToJson(CodeWordModel instance) =>
    <String, dynamic>{
      'CodeWord': instance.CodeWord,
      'U0': instance.U0,
      'C': instance.C,
      'U': instance.U,
      'U1': instance.U1,
      'U2': instance.U2,
      'U3': instance.U3,
      'parents': instance.parents
    };
