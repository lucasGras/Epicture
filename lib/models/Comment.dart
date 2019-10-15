import 'package:json_annotation/json_annotation.dart';

part 'Comment.g.dart';

@JsonSerializable()
class Comment {
    String comment;
    String author;
    int ups;
    int downs;
    String vote;
    dynamic id;

    Comment(this.comment, this.vote, this.author, this.downs, this.ups, this.id);

    factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

    Map<String, dynamic> toJson() => _$CommentToJson(this);
}