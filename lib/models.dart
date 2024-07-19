import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum FacingMode { back, front }

@JsonSerializable()
class MediaDeviceInfo {
  @JsonKey(unknownEnumValue: FacingMode.back)
  final FacingMode facingMode;

  final String? localizedName;

  final List<MediaDeviceResolution> resolutions;

  const MediaDeviceInfo({
    this.facingMode = FacingMode.back,
    this.localizedName,
    this.resolutions = const [],
  });

  factory MediaDeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$MediaDeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDeviceInfoToJson(this);
}

@JsonSerializable()
class MediaDeviceResolution {
  final int width;
  final int height;

  const MediaDeviceResolution({this.width = 0, this.height = 0});

  factory MediaDeviceResolution.fromJson(Map<String, dynamic> json) =>
      _$MediaDeviceResolutionFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDeviceResolutionToJson(this);
}
