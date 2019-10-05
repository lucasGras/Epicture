import 'package:json_annotation/json_annotation.dart';
import 'package:epicture/models/GalleryImage.dart';

part 'GalleryList.g.dart';

@JsonSerializable()
class GalleryList {
    @JsonKey(name: "data")
    List<GalleryImage> gallery;

    GalleryList(this.gallery);

    factory GalleryList.fromJson(Map<String, dynamic> json) => _$GalleryListFromJson(json);

    Map<String, dynamic> toJson() => _$GalleryListToJson(this);
}