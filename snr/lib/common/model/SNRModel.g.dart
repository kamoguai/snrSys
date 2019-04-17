// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SNRModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SNRModel _$SNRModelFromJson(Map<String, dynamic> json) {
  return SNRModel(
      json['SNR'] as String,
      json['PWR'] as String,
      json['U0'] as String,
      json['U1'] as String,
      json['U2'] as String,
      json['U3'] as String,
      (json['parents'] as List)
          ?.map((e) =>
              e == null ? null : SNRModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SNRModelToJson(SNRModel instance) => <String, dynamic>{
      'SNR': instance.SNR,
      'PWR': instance.PWR,
      'U0': instance.U0,
      'U1': instance.U1,
      'U2': instance.U2,
      'U3': instance.U3,
      'parents': instance.parents
    };
