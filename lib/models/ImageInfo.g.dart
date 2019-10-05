// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) {
  return ImageInfo(json['id'] as String, json['width'] as int,
      json['height'] as int, json['type'] as String);
}

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height
    };
