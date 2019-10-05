// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GalleryList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryList _$GalleryListFromJson(Map<String, dynamic> json) {
  return GalleryList((json['data'] as List)
      ?.map((e) =>
          e == null ? null : GalleryImage.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$GalleryListToJson(GalleryList instance) =>
    <String, dynamic>{'data': instance.gallery};
