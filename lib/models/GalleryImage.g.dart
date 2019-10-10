// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GalleryImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryImage _$GalleryImageFromJson(Map<String, dynamic> json) {
  return GalleryImage(
      json['account_url'] as String,
      json['title'] as String,
      json['id'] as String,
      json['comment_count'] as int,
      json['cover'] as String,
      json['downs'] as int,
      json['ups'] as int,
      json['views'] as int,
      (json['images'] as List)
          ?.map((e) =>
              e == null ? null : ImageInfo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['favorite'] as bool)
    ..vote = json['vote'] as String;
}

Map<String, dynamic> _$GalleryImageToJson(GalleryImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'account_url': instance.username,
      'views': instance.views,
      'ups': instance.ups,
      'downs': instance.downs,
      'comment_count': instance.comments,
      'images': instance.imagesInfo,
      'favorite': instance.isFavorite,
      'vote': instance.vote
    };
