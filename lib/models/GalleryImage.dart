import 'package:json_annotation/json_annotation.dart';
import 'package:epicture/models/ImageInfo.dart';

part 'GalleryImage.g.dart';

@JsonSerializable()
class GalleryImage {
    String id;
    String title;
    String cover;
    @JsonKey(name: "account_url")
    String username;
    int views;
    int ups;
    int downs;
    @JsonKey(name: "comment_count")
    int comments;
    @JsonKey(name: "images")
    List<ImageInfo> imagesInfo;
    @JsonKey(name: "favorite")
    bool isFavorite;
    String vote;

    GalleryImage(this.username, this.title, this.id, this.comments, this.cover, this.downs,
        this.ups, this.views, this.imagesInfo, this.isFavorite);

    factory GalleryImage.fromJson(Map<String, dynamic> json) => _$GalleryImageFromJson(json);

    Map<String, dynamic> toJson() => _$GalleryImageToJson(this);
}