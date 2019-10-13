// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(json['comment'] as String, json['vote'] as String,
      json['author'] as String, json['downs'] as int, json['ups'] as int);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment': instance.comment,
      'author': instance.author,
      'ups': instance.ups,
      'downs': instance.downs,
      'vote': instance.vote
    };
