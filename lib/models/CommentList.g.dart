// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentList _$CommentListFromJson(Map<String, dynamic> json) {
  return CommentList((json['data'] as List)
      ?.map(
          (e) => e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$CommentListToJson(CommentList instance) =>
    <String, dynamic>{'data': instance.list};
