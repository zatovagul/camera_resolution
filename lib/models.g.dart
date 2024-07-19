// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaDeviceInfo _$MediaDeviceInfoFromJson(Map<String, dynamic> json) =>
    MediaDeviceInfo(
      facingMode: $enumDecodeNullable(_$FacingModeEnumMap, json['facingMode'],
              unknownValue: FacingMode.back) ??
          FacingMode.back,
      localizedName: json['localizedName'] as String?,
      resolutions: (json['resolutions'] as List<dynamic>?)
              ?.map((e) =>
                  MediaDeviceResolution.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MediaDeviceInfoToJson(MediaDeviceInfo instance) =>
    <String, dynamic>{
      'facingMode': _$FacingModeEnumMap[instance.facingMode]!,
      'localizedName': instance.localizedName,
      'resolutions': instance.resolutions,
    };

const _$FacingModeEnumMap = {
  FacingMode.back: 'back',
  FacingMode.front: 'front',
};

MediaDeviceResolution _$MediaDeviceResolutionFromJson(
        Map<String, dynamic> json) =>
    MediaDeviceResolution(
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MediaDeviceResolutionToJson(
        MediaDeviceResolution instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
