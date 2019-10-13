import 'package:json_annotation/json_annotation.dart';

part 'Comment.g.dart';

@JsonSerializable()
class Comment {
    String comment;
    String author;
    int ups;
    int downs;
    String vote;


    Comment(this.comment, this.vote, this.author, this.downs, this.ups);

    factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

    Map<String, dynamic> toJson() => _$CommentToJson(this);
}